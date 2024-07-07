import 'package:flutter/material.dart';
import 'package:my_hand/models/product_model.dart';


class MyDataTable extends StatefulWidget {
  const MyDataTable({Key? key, required this.products}) : super(key: key);

  final List<Product> products;

  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  void _deleteProduct(int index) {
    setState(() {
      widget.products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: const Text('العملية')),
        DataColumn(label: const Text('المنتج')),
        DataColumn(label: const Text('الوزن')),
        DataColumn(label: const Text('السعر')),
        DataColumn(label: const Text('إرسال')),
        DataColumn(label: const Text('حذف')),
      ],
      rows: widget.products.map((product) {
        return DataRow(
          cells: [
            DataCell(Center(child: Text(product.action.toString()))),
            DataCell(
              Center(child: Text(product.name.toString())),
            ),
            DataCell(Center(child: Text('${product.weight} kg'))),
            DataCell(Center(child: Text('${product.price} L.E'))),
            DataCell(Center(
              child: Text(
                  '${(product.weight - (product.packageWeight * product.numberPackage)) * product.price} L.E'),
            )),
            DataCell( 
              Center(
                child: IconButton(
                  onPressed: () =>
                      _deleteProduct(widget.products.indexOf(product)),
                  icon: const Icon(Icons.delete),
                ),
              ),
            ),
          ],
          onSelectChanged: (selected) {
            // Handle row selection if needed
          },
        );
      }).toList(),
      dataRowColor:
          MaterialStateProperty.all<Color>(const Color.fromARGB(255, 232, 217, 216)),
      headingTextStyle: const TextStyle(),
      border: const TableBorder(
        bottom: BorderSide(width: 1),
        top: BorderSide(width: 1),
        verticalInside: BorderSide(width: 1),
      ),
      horizontalMargin: 15,
      columnSpacing: 10,
      showCheckboxColumn: false,
    );
  }
}
