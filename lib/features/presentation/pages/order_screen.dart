import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:my_hand/screens/invoice_screen.dart';
import 'package:my_hand/core/util/helper_date_price.dart';
import 'package:my_hand/core/util/helper_widgets.dart';
import 'package:my_hand/features/data/models/product_model.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:my_hand/core/util/utils.dart';
import 'package:my_hand/features/widgets/button.dart';
import 'package:my_hand/features/widgets/data_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';

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
  final _packageNumberController = TextEditingController();
  final _packageWeightController = TextEditingController();
  final _priceController = TextEditingController();
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
  ];

  String? _selectedProduct;
  final _weightController = TextEditingController();

  @override
  void initState() {
    _packageWeightController.text = "2";
    _packageNumberController.text = "0";
    super.initState();
  }

  // void submitForm(List<Product> products) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (ctx) => InvoiceScreen(
  //         products: products,
  //         totalCost: _totalCost,
  //         customerName: '${_customerNameController.text}',
  //       ),
  //     ),
  //   );
  // }

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

  void _addProduct() {
    // final action =
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
      _packageNumberController.clear();
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

      extendBody: true,
      // Send data button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                width: screenSize.width,
                height: 500,
                child: Column(
                  children: [
                    addVerticalSpace(5),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: MyDataTable(products: products),
                    ),
                    TextButton(
                        onPressed: () async {
                          final pdfDoc = await generatePDF(
                              PdfPageFormat.a4,
                              products,
                              _totalCost,
                              _customerNameController.text);
                          // Get a temporary directory path to save the PDF
                          final tempDir = await getTemporaryDirectory();
                          final filePath = '${tempDir.path}/invoice.pdf';
                          // Write the PDF bytes to the temporary file
                          await File(filePath).writeAsBytes(pdfDoc);
                          await Share.shareXFiles([XFile(filePath)]);
                        },
                        child: const Text('Send'))
                  ],
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
      // bottomNavigationBar: const BottomAppBar(
      //   height: 10,
      //   shape: CircularNotchedRectangle(),
      // ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: Container(
            width: screenSize.width * 0.95,
            height: screenSize.height,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(5),
              child: Form(
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
                              value.length < 7) {
                            return 'Please enter at least 7 characters.';
                          }
                          return null;
                        },
                      ),
                    ),

                    addVerticalSpace(5),
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
                                    if (states.contains(WidgetState.pressed)) {
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
                                        : const Color.fromARGB(
                                            255, 35, 34, 34); // Default color
                                  },
                                ),
                              ),
                            ),
                            addHorizontalSpace(5),
                            TextButton(
                              onPressed: () {
                                _activeTextButton('بـيع');
                                _action = 'بـيع';
                              },
                              child:
                                  Text('بـيع', style: _textTheme.headlineSmall),
                              style: ButtonStyle(
                                foregroundColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                  (Set<WidgetState> states) {
                                    if (states.contains(WidgetState.pressed)) {
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
                                        : const Color.fromARGB(
                                            255, 35, 34, 34); // Default color
                                  },
                                ),
                              ),
                            ),
                            addHorizontalSpace(5),
                            TextButton(
                              onPressed: () {
                                _activeTextButton('شراء');
                                _action = 'شراء';
                              },
                              child:
                                  Text('شراء', style: _textTheme.headlineSmall),
                              style: ButtonStyle(
                                foregroundColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                  (Set<WidgetState> states) {
                                    if (states.contains(WidgetState.pressed)) {
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
                                        : const Color.fromARGB(
                                            255, 35, 34, 34); // Default color
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Product selection
                    DropdownSearch(
                      key: _dropdownSearchKey,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      items: _productList,
                      selectedItem: _selectedProduct,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
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
                    // Package weight
                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Weight
                          Flexible(
                            flex: 4,
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
                          addHorizontalSpace(10),
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
                          addHorizontalSpace(10),
                          // number of packages
                          Flexible(
                            flex: 3,
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
                        ],
                      ),
                    ),
                    // price
                    TextFormField(
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
                    addVerticalSpace(10),
                    // Add product button
                    GradientButtonFb1(
                      text: 'أضف منتج',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addProduct();
                        }
                      },
                    ),
                    addVerticalSpace(10),
                    Text(
                      formattedDate ?? 'أكمل بيانات المنتج أولا',
                      style: const TextStyle(color: Colors.redAccent),
                    ), //print date here
                    addVerticalSpace(10),

                    // Products table
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: MyDataTable(products: products)),

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
      ),
    );
  }
}
