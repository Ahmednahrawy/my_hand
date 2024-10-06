import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';

import 'package:my_hand/config/theme/colors.dart';
import 'package:my_hand/config/theme/styles.dart';
import 'package:my_hand/core/helpers/helper_date_price.dart';
import 'package:my_hand/core/helpers/product_list_constants.dart';
import 'package:my_hand/core/helpers/spacing.dart';
import 'package:my_hand/core/helpers/utils.dart';
import 'package:my_hand/core/widgets/text_button.dart';
import 'package:my_hand/core/widgets/text_form_field.dart';
import 'package:my_hand/features/data/models/product_model.dart';
import 'package:my_hand/features/drawer/side_nav.dart';
import 'package:my_hand/features/orderscreen/ui/widgets/customer_name.dart';
import 'package:my_hand/features/orderscreen/ui/widgets/data_table.dart';

class Orderscreen extends StatefulWidget {
  const Orderscreen({super.key});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  String? formattedDate;
  String? formattedTime;
  // format date now
  late DateTime selectedDate;

  final List<Product> products = [];
  final List<String> actions = ['تخزين', 'بـيع', 'شراء'];
  String? _action;
  String? buttonType;
  String? _customerName;
  final GlobalKey<FormState> _dropdownSearchKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  final _payKey = GlobalKey<FormState>();
  final _packageNumberController = TextEditingController();
  final _packageWeightController = TextEditingController();
  final _priceController = TextEditingController();
  final _payController = TextEditingController();
  final List<String> _productList = ProductListConstants.productList;

  String? _selectedProduct;
  final _weightController = TextEditingController();

  @override
  void initState() {
    _packageWeightController.text = "2";
    // _packageNumberController.text = "0";
    // _priceController.text = "0";
    _payController.text = "0";
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    formattedDate = Utils.formatDate(selectedDate);
    formattedTime = Utils.formateTimeNow(selectedDate);
  }

  double get _totalCost => products.fold(
        0,
        (sum, product) =>
            sum +
            (product.weight - (product.packageWeight * product.numberPackage)) *
                (product.action == "شراء"
                    ? product.price
                    : (-1 * product.price)),
      );
  double get _paid {
    return double.tryParse(_payController.text) ?? 0.0;
  }

  double get _rest {
    return ((_totalCost < 0) ? (-_totalCost) : _totalCost) - _paid;
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }

  // This function will be passed to the Autocomplete widget as a callback
  void _handleCustomerSelection(String? customerName) {
    setState(() {
      _customerName = customerName; // Store the selected customer name
    });
  }

  void _addProduct() {
    if (_action == null) {
      _showToast('Please select an action (تخزين, بـيع, شراء)');
      return;
    }
    if (_selectedProduct == null) {
      _showToast('Please select a product');
      return;
    }
    if (_formKey.currentState!.validate()) {
      setState(() {
        products.add(
          Product(
            name: _selectedProduct!,
            weight: double.parse(_weightController.text),
            packageWeight: double.parse(_packageWeightController.text),
            price: double.parse(_priceController.text),
            numberPackage: int.parse(_packageNumberController.text),
            action: _action!,
          ),
        );
      });
      _weightController.clear();
      // _packageNumberController.text = "0";
    }
    _selectDate(context);
  }

  // send invoice
  void _sendInvoice() async {
    _selectDate(context);
    if (_payKey.currentState!.validate()) {
      try {
        final pdfDoc = await generatePDF(
            PdfPageFormat.a4,
            products,
            _customerName!,
            _totalCost,
            _paid,
            _rest,
            formattedDate,
            formattedTime);
        // Get a temporary directory path to save the PDF
        final tempDir = await getTemporaryDirectory();
        final filePath =
            '${tempDir.path}/${_customerName}-${formattedDate}-${formattedTime}.pdf';
        final file = File(filePath);
        await file.writeAsBytes(pdfDoc);
        await Share.shareXFiles([XFile(filePath)]);
      } catch (e) {
        Navigator.of(context).pop();
        _showToast('فشل إرسال فاتورة: $e');
      }
    }
  }

// activity button active color
  void _activeTextButton(String buttonType) {
    setState(() {
      _action = buttonType;
    });
  }

  @override
  void dispose() {
    _dropdownSearchKey.currentState?.dispose();
    _formKey.currentState?.dispose();
    _payKey.currentState?.dispose();
    _packageNumberController.dispose();
    _packageWeightController.dispose();
    _priceController.dispose();
    _payController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // media query size
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text(
          "إصدار فاتورة",
          style: TextStyles.font20MainBlueBold,
        ),
      ),
      drawer: const SideNav(),
      extendBody: true,
      // Send data button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: ColorsManager.moreLighterGray,
            context: context,
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SizedBox(
                  width: screenSize.width,
                  height: 500,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        verticalSpace(5),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: MyDataTable(
                            products: products,
                            isInModal: true,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'إجالي المبلغ: $_totalCost  L.E',
                              textDirection: TextDirection.rtl,
                            ),
                            Text(
                              'التحصيل : $_paid L.E ',
                              textDirection: TextDirection.rtl,
                            ),
                            Text(
                              'الباقي: $_rest L.E',
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                        verticalSpace(5),
                        // paying
                        Form(
                          key: _payKey,
                          child: AppTextFormField(
                            controller: _payController,
                            labelText: 'تحصيل',
                            suffixText: 'L.E',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter price.';
                              }
                              return null;
                            },
                          ),
                        ),

                        verticalSpace(10),
                        AppTextButton(
                          onPressed: _sendInvoice,
                          buttonText: 'إرسال',
                          textStyle: TextStyles.font18WhiteMedium,
                          buttonWidth: screenSize.width * 0.5,
                          backgroundColor: ColorsManager.gray,
                        ),
                        verticalSpace(10),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.share_sharp,
          size: 28,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: Container(
            width: screenSize.width * 0.95,
            height: screenSize.height,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Customer name
                        Card(
                          child: CustomerNameAutoComplete(
                            onCustomerSelected: _handleCustomerSelection,
                          ),
                        ),
                        verticalSpace(5),
                        // main activity buy,sell, store
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: actions.map((action) {
                            return Flexible(
                              flex: 1,
                              child: AppTextButton(
                                borderRadius: 9,
                                onPressed: () {
                                  _activeTextButton(action);
                                },
                                buttonWidth: screenSize.width * 0.28,
                                buttonHeight: 12,
                                verticalPadding: 2,
                                buttonText: action,
                                backgroundColor: _action == action
                                    ? ColorsManager.lavander
                                    : ColorsManager.mainBlue,
                                textStyle: TextStyles.font16WhiteSemiBold,
                              ),
                            );
                          }).toList(),
                        ),
                        verticalSpace(10),
                        // Product selection
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 3,
                              child: DropdownSearch<String>(
                                key: _dropdownSearchKey,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                items: (filter, infiniteScrollProps) =>
                                    _productList,
                                selectedItem: _selectedProduct,
                                decoratorProps: const DropDownDecoratorProps(
                                  decoration: InputDecoration(
                                    labelText: 'المنتج',
                                    suffixIcon: Icon(Icons.search),
                                    hintText: 'Search',
                                  ),
                                ),
                                popupProps: PopupProps.menu(
                                  fit: FlexFit.tight,
                                  itemBuilder:
                                      (context, item, isDisabled, isSelected) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: ColorsManager
                                                .lightGray, // Border color
                                            width: 1.0, // Border width
                                          ),
                                        ),
                                      ),
                                      child: ListTile(
                                        title: Text(item),
                                      ),
                                    );
                                  },
                                  showSearchBox: true,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    // _productController.text = value;
                                    _selectedProduct = value;
                                  });
                                },
                              ),
                            ),
                            // Weight
                            Flexible(
                              flex: 4,
                              child: AppTextFormField(
                                controller: _weightController,
                                labelText: 'الوزن أو العدد',
                                suffixText: 'kg',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _weightController
                                        .clear(); // Clear the input when the clear icon is pressed
                                    setState(() {
                                      _weightController.text = '';
                                    });
                                  },
                                  icon: _weightController.text == ''
                                      ? Icon(null)
                                      : Icon(Icons.clear),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter weight.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(10),
                        // Package weight
                        Card(
                          color: ColorsManager.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.w, horizontal: 5.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // package weight
                                Flexible(
                                  flex: 2,
                                  child: AppTextFormField(
                                    controller: _packageWeightController,
                                    labelText: 'وزن العبوة',
                                    suffixText: 'kg',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'أدخل وزن   \n العبوة الفارغة';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                horizontalSpace(1.w),
                                // number of packages
                                Flexible(
                                  flex: 2,
                                  child: AppTextFormField(
                                    controller: _packageNumberController,
                                    labelText: 'عدد العبوات',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'أدخل عدد العبوات أولا';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                // price
                                Flexible(
                                  flex: 4,
                                  child: AppTextFormField(
                                    controller: _priceController,
                                    labelText: 'السعر',
                                    suffixText: 'L.E',
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        _priceController
                                            .clear(); // Clear the input when the clear icon is pressed
                                        setState(() {
                                          _priceController.text = '';
                                        });
                                      },
                                      icon: _priceController.text == ''
                                          ? Icon(null)
                                          : Icon(Icons.clear),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter price.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        verticalSpace(10),
                      ],
                    ),
                  ),
                  // Add product button
                  AppTextButton(
                    onPressed: _addProduct,
                    buttonText: 'أضف منتج',
                    textStyle: TextStyles.font16WhiteSemiBold,
                    backgroundColor: ColorsManager.mainBlue,
                    buttonWidth: screenSize.width * 0.6,
                  ),
                  verticalSpace(10),
                  // Products table
                  SizedBox(
                    width: screenSize.width,
                    child: MyDataTable(
                      products: products,
                      isInModal: false,
                    ),
                  ),
                  // Total cost
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Total cost: $_totalCost L.E'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
