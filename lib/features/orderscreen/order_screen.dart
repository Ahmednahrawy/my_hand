import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_hand/core/helpers/spacing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';

import 'package:my_hand/core/helpers/helper_date_price.dart';
import 'package:my_hand/core/helpers/utils.dart';
import 'package:my_hand/features/data/models/product_model.dart';
import 'package:my_hand/features/presentation/pages/side_nav.dart';
import 'package:my_hand/features/widgets/button.dart';
import 'package:my_hand/features/widgets/data_table.dart';

class Orderscreen extends StatefulWidget {
  const Orderscreen({super.key});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  String? formattedDate;
  bool isPurchaseButtonPressed = false;
  bool isSellButtonPressed = false;
  bool isStorageButtonPressed = false;
  final List<Product> products = [];
  // format date now
  late DateTime selectedDate;

  String? _action;
  final TextEditingController _customerNameController = TextEditingController();
  final GlobalKey<FormState> _dropdownSearchKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _payKey = GlobalKey<FormState>();
  final _packageNumberController = TextEditingController();
  final _packageWeightController = TextEditingController();
  final _priceController = TextEditingController();
  final _payController = TextEditingController();
  final List _productList = [
    'صعيدي',
    'أرضيات',
    'منشر',
    'فريحي 0',
    'فريحي 1',
    'فريحي 2',
    'فريحي 3',
    'بشاير',
    'ارغاون',
    'عزاوي',
    'علف',
    'دبس',
    'عجيزي',
    'حامض',
    'كلاماتا',
    'دولسي',
    'زيتون زيت',
    'زيت',
    'علب 10ك',
    'علب 5ك',
    'علب 800',
    'علب 700',
    'علب 1.4ك',
    'علب 1.6ك',
    'شحن',
  ];

  String? _selectedProduct;
  final _weightController = TextEditingController();

  @override
  void initState() {
    _packageWeightController.text = "2";
    _packageNumberController.text = "0";
    _priceController.text = "0";
    _payController.text = "0";
    super.initState();
  }


  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    formattedDate = Utils.formatDate(selectedDate);
    setState(() {
      selectedDate;
    });
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

  void _addProduct() {
    // final action =
    // if (_selectedProduct == null) {
    //   // Show an error message or dialog to inform the user
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Please select a product')),
    //   );
    //   return;
    // }

    // if (_action == null) {
    //   // Show an error message or dialog to inform the user
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //         content: Text('Please select an action (تخزين, بـيع, شراء)')),
    //   );
    //   return;
    // }
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
      // _productController.clear();
      _weightController.clear();
      // _packageWeightController.clear();
      // _priceController.clear();
      _packageNumberController.text = "0";
      _selectDate(context); // Update the selected date when adding a product
    }
  }

  // send invoice
  void _sendInvoice() async {
    if (_payKey.currentState!.validate()) {
      final pdfDoc = await generatePDF(
        PdfPageFormat.a4,
        products,
        _customerNameController.text,
        _totalCost,
        _paid,
        _rest,
      );
      // Get a temporary directory path to save the PDF
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/${_customerNameController.text}.pdf';
      // Write the PDF bytes to the temporary file
      await File(filePath).writeAsBytes(pdfDoc);
      await Share.shareXFiles([XFile(filePath)]);

      _selectDate(context); // Update the selected date when adding a product
    }
  }

// activity button active color
  void _activeTextButton(String buttonType) {
    setState(() {
      // Set the corresponding button as pressed
      isStorageButtonPressed = buttonType == 'تخزين';
      isSellButtonPressed = buttonType == 'بـيع';
      isPurchaseButtonPressed = buttonType == 'شراء';
    });
  }

  @override
  Widget build(BuildContext context) {
    // media query size
    final screenSize = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text(
          "إصدار فاتورة",
          textDirection: TextDirection.rtl,
        ),
      ),
      drawer: const SideNav(),
      extendBody: true,
      // Send data button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
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
                          child: TextFormField(
                            controller: _payController,
                            decoration: const InputDecoration(
                              labelText: 'تحصيل',
                              suffixText: 'L.E',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter price.';
                              }
                              return null;
                            },
                          ),
                        ),

                        verticalSpace(5),
                        ElevatedButton(
                            onPressed: _sendInvoice,
                            child: const Text('إرسال')),
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
          Icons.picture_as_pdf_outlined,
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
                          child: TextFormField(
                            controller: _customerNameController,
                            decoration: const InputDecoration(
                              labelText: "إسم العميل",
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 5) {
                                return 'Please enter at least 7 characters.';
                              }
                              return null;
                            },
                          ),
                        ),

                        verticalSpace(5),
                        // main activity buy,sell, store
                        Card(
                          child: Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _activeTextButton('تخزين');
                                    _action = 'تخزين';
                                  },
                                  child: Text('تخزين',
                                      style: _textTheme.headlineSmall),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        WidgetStateProperty.resolveWith<Color>(
                                      (Set<WidgetState> states) {
                                        if (states
                                            .contains(WidgetState.pressed)) {
                                          // The button is pressed
                                          return Theme.of(context)
                                              .colorScheme
                                              .secondary; // Change to the desired color when pressed
                                        }
                                        return Theme.of(context)
                                            .colorScheme
                                            .primary; // Default color
                                      },
                                    ),
                                    backgroundColor:
                                        WidgetStateProperty.resolveWith<Color>(
                                      (Set<WidgetState> states) {
                                        if (isStorageButtonPressed) {
                                          // The button is pressed
                                          return Theme.of(context)
                                                      .colorScheme
                                                      .brightness ==
                                                  Brightness.light
                                              ? Colors.deepOrange
                                              : const Color.fromARGB(
                                                  255, 36, 8, 69);
                                        }
                                        return Theme.of(context)
                                                    .colorScheme
                                                    .brightness ==
                                                Brightness.light
                                            ? Colors.orangeAccent
                                            : const Color.fromARGB(255, 35, 34,
                                                34); // Default color
                                      },
                                    ),
                                  ),
                                ),
                                horizontalSpace(5),
                                TextButton(
                                  onPressed: () {
                                    _activeTextButton('بـيع');
                                    _action = 'بـيع';
                                  },
                                  child: Text('بـيع',
                                      style: _textTheme.headlineSmall),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        WidgetStateProperty.resolveWith<Color>(
                                      (Set<WidgetState> states) {
                                        if (states
                                            .contains(WidgetState.pressed)) {
                                          // The button is pressed
                                          return Theme.of(context)
                                              .colorScheme
                                              .secondary; // Change to the desired color when pressed
                                        }
                                        return Theme.of(context)
                                            .colorScheme
                                            .primary; // Default color
                                      },
                                    ),
                                    backgroundColor:
                                        WidgetStateProperty.resolveWith<Color>(
                                      (Set<WidgetState> states) {
                                        if (isSellButtonPressed) {
                                          // The button is pressed
                                          return Theme.of(context)
                                                      .colorScheme
                                                      .brightness ==
                                                  Brightness.light
                                              ? Colors.deepOrange
                                              : const Color.fromARGB(
                                                  255, 36, 8, 69);
                                        }
                                        return Theme.of(context)
                                                    .colorScheme
                                                    .brightness ==
                                                Brightness.light
                                            ? Colors.orangeAccent
                                            : const Color.fromARGB(255, 35, 34,
                                                34); // Default color
                                      },
                                    ),
                                  ),
                                ),
                                horizontalSpace(5),
                                TextButton(
                                  onPressed: () {
                                    _activeTextButton('شراء');
                                    _action = 'شراء';
                                  },
                                  child: Text('شراء',
                                      style: _textTheme.headlineSmall),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        WidgetStateProperty.resolveWith<Color>(
                                      (Set<WidgetState> states) {
                                        if (states
                                            .contains(WidgetState.pressed)) {
                                          // The button is pressed
                                          return Theme.of(context)
                                              .colorScheme
                                              .secondary; // Change to the desired color when pressed
                                        }
                                        return Theme.of(context)
                                            .colorScheme
                                            .primary; // Default color
                                      },
                                    ),
                                    backgroundColor:
                                        WidgetStateProperty.resolveWith<Color>(
                                      (Set<WidgetState> states) {
                                        if (isPurchaseButtonPressed) {
                                          // The button is pressed
                                          return Theme.of(context)
                                                      .colorScheme
                                                      .brightness ==
                                                  Brightness.light
                                              ? Colors.deepOrange
                                              : const Color.fromARGB(
                                                  255, 36, 8, 69);
                                        }
                                        return Theme.of(context)
                                                    .colorScheme
                                                    .brightness ==
                                                Brightness.light
                                            ? Colors.orangeAccent
                                            : const Color.fromARGB(255, 35, 34,
                                                34); // Default color
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Product selection
                        Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: DropdownSearch(
                                key: _dropdownSearchKey,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                items: _productList,
                                selectedItem: _selectedProduct,
                                dropdownDecoratorProps:
                                    const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: 'المنتج',
                                    suffixIcon: Icon(Icons.search),
                                    hintText: 'Search',
                                  ),
                                ),
                                popupProps: const PopupProps.bottomSheet(
                                  bottomSheetProps: BottomSheetProps(
                                    elevation: 16,
                                    backgroundColor: Color(0xFFAADCEE),
                                  ),
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
                              flex: 1,
                              child: TextFormField(
                                controller: _weightController,
                                decoration: const InputDecoration(
                                  labelText: 'الوزن أو العدد',
                                  suffixText: 'kg',
                                ),
                                keyboardType: TextInputType.number,
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
                        // Package weight
                        Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // package weight
                              Flexible(
                                flex: 2,
                                child: TextFormField(
                                  controller: _packageWeightController,
                                  decoration: const InputDecoration(
                                    labelText: 'وزن العبوة',
                                    suffixText: 'kg',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'أدخل وزن   \n العبوة الفارغة';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              horizontalSpace(10),
                              // number of packages
                              Flexible(
                                flex: 2,
                                child: TextFormField(
                                  controller: _packageNumberController,
                                  decoration: const InputDecoration(
                                    labelText: 'عدد العبوات',
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.number,
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
                                child: TextFormField(
                                  controller: _priceController,
                                  decoration: const InputDecoration(
                                    labelText: 'السعر',
                                    suffixText: 'L.E',
                                  ),
                                  keyboardType: TextInputType.number,
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
                        verticalSpace(10),
                      ],
                    ),
                  ),
                  // Add product button
                  GradientButtonFb1(
                    text: 'أضف منتج',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _addProduct();
                      }
                    },
                  ),
                  verticalSpace(10),
                  Text(
                    formattedDate ?? 'أكمل بيانات المنتج أولا',
                    style: const TextStyle(color: Colors.redAccent),
                  ), //print date here
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
