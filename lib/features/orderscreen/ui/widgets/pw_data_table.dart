import 'package:my_hand/features/data/models/product_model.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfMyDataTable extends pw.StatelessWidget {
  final List<Product> products;
  final double totalCost;

  PdfMyDataTable({required this.products, required this.totalCost});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Table(
      border: pw.TableBorder.symmetric(
        outside: const pw.BorderSide(width: 2),
        inside: const pw.BorderSide(width: 1),
      ),
      children: [
        pw.TableRow(
          children: [
            _buildCell(
              'العملية',
            ),
            _buildCell(
              'المنتج',
            ),
            _buildCell(
              'الوزن',
            ),
            _buildCell(
              'وزن الفارغ',
            ),
            _buildCell(
              'عدد الفارغ',
            ),
            _buildCell(
              'صافي الوزن',
            ),
            _buildCell(
              'السعر',
            ),
            _buildCell(
              'إجمالي',
            ),
          ],
          // decoration: pw.BoxDecoration(color: PdfColor(10, 19, 20)),
        ),
        for (var product in products)
          pw.TableRow(
            children: [
              _buildCell(product.action.toString()),
              _buildCell(product.name.toString()),
              _buildCell('${product.weight} kg'),
              _buildCell('${product.packageWeight} kg'),
              _buildCell(product.numberPackage.toString()),
              _buildCell(
                  '${(product.weight - (product.packageWeight * product.numberPackage))} kg'),
              _buildCell('${product.price} L.E'),
              _buildCell(
                  '${(product.weight - (product.packageWeight * product.numberPackage)) * product.price} L.E'),
            ],
          ),
      ],
    );
  }

  pw.Widget _buildCell(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: const pw.TextStyle(fontSize: 17),
      ),
    );
  }
}
