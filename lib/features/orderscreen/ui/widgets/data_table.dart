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
        if (widget.isInModal) _buildDataColumn('حذف'),
        _buildDataColumn('العملية'),
        _buildDataColumn('المنتج'),
        _buildDataColumn('الوزن'),
        if (widget.isInModal) _buildDataColumn("عدد العبوات"),
        if (widget.isInModal) _buildDataColumn("صافي الوزن"),
        _buildDataColumn('السعر'),
        _buildDataColumn('إجمالي'),
      ],
      rows: widget.products.map((product) {
        return DataRow(
          cells: [
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
            _buildDataCell(product.action.toString()),
            _buildDataCell(product.name.toString()),
            _buildDataCell('${product.weight}  kg'),
            if (widget.isInModal) _buildDataCell('${product.numberPackage}'),
            if (widget.isInModal)
              _buildDataCell(
                  '${(product.weight - (product.packageWeight * product.numberPackage))}  kg'),
            _buildDataCell('${product.price} L.E'),
            _buildDataCell(
                '${(product.weight - (product.packageWeight * product.numberPackage)) * product.price} L.E'),
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

_buildDataCell(String text) {
  return DataCell(
    Center(
      child: Text(text),
    ),
  );
}

_buildDataColumn(String text) {
  return DataColumn(
    label: Text(text),
  );
}
