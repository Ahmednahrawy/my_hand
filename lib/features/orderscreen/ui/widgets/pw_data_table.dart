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
              'الوزن-كجم',
            ),
            _buildCell(
              'وزن الفارغ-كجم',
            ),
            _buildCell(
              'عدد الفارغ',
            ),
            _buildCell(
              'صافي الوزن-كجم',
            ),
            _buildCell(
              'السعر - جنيه',
            ),
            _buildCell(
              'إجمالي - جنيه',
            ),
          ],
          // decoration: pw.BoxDecoration(color: PdfColor(10, 19, 20)),
        ),
        for (var product in products)
          pw.TableRow(
            children: [
              _buildCell(product.action.toString()),
              _buildCell(product.name.toString()),
              _buildCell('${product.weight}'),
              _buildCell('${product.packageWeight}'),
              _buildCell(product.numberPackage.toString()),
              _buildCell(
                  '${(product.weight - (product.packageWeight * product.numberPackage))}'),
              _buildCell('${product.price}'),
              _buildCell(
                  '${(product.weight - (product.packageWeight * product.numberPackage)) * product.price}'),
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
