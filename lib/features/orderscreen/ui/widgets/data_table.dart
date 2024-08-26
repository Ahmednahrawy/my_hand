import 'package:flutter/material.dart';
import 'package:my_hand/features/data/models/product_model.dart';

class MyDataTable extends StatefulWidget {
  const MyDataTable({Key? key, required this.products, required this.isInModal})
      : super(key: key);

  final List<Product> products;
  final bool isInModal;

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
      columns: [
        const DataColumn(label: Text('العملية')),
        const DataColumn(label: Text('المنتج')),
        const DataColumn(
          label: Text('الوزن'),
        ),
        if (widget.isInModal) const DataColumn(label: Text("عدد العبوات")),
        if (widget.isInModal) const DataColumn(label: Text("صافي الوزن")),
        const DataColumn(label: Text('السعر')),
        const DataColumn(label: Text('إجمالي')),
        if (widget.isInModal) const DataColumn(label: Text('حذف')),
      ],
      rows: widget.products.map((product) {
        return DataRow(
          cells: [
            DataCell(Center(child: Text(product.action.toString()))),
            DataCell(
              Center(child: Text(product.name.toString())),
            ),
            DataCell(Center(child: Text('${product.weight}  kg'))),
            if (widget.isInModal)
              DataCell(Center(child: Text('${product.numberPackage}'))),
            if (widget.isInModal)
              DataCell(Center(
                  child: Text(
                      '${(product.weight - (product.packageWeight * product.numberPackage))}  kg'))),
            DataCell(Center(child: Text('${product.price} L.E'))),
            DataCell(Center(
              child: Text(
                  '${(product.weight - (product.packageWeight * product.numberPackage)) * product.price} L.E'),
            )),
            if (widget.isInModal)
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
      dataRowColor: WidgetStateProperty.all<Color>(
          const Color.fromARGB(255, 232, 217, 216)),
      headingTextStyle: const TextStyle(),
      border: const TableBorder(
        bottom: BorderSide(width: 1),
        top: BorderSide(width: 1),
        verticalInside: BorderSide(width: 1),
      ),
      horizontalMargin: 10,
      columnSpacing: 5,
      showCheckboxColumn: false,
    );
  }
}
