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
          inside: const pw.BorderSide(width: 1)),
      children: [
        pw.TableRow(
          children: [
            pw.Text('العملية',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 18)),
            pw.Text('المنتج',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 18)),
            pw.Text('الوزن',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 18)),
            pw.Text('وزن الفارغ',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 18)),
            pw.Text('عدد الفارغ',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 18)),
            pw.Text('صافي الوزن',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 18)),
            pw.Text('السعر',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 18)),
            pw.Text('إجمالي',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 18)),
          ],
          // decoration: pw.BoxDecoration(color: PdfColor(10, 19, 20)),
        ),
        for (var product in products)
          pw.TableRow(
            children: [
              pw.Text(product.action.toString(),
                  textAlign: pw.TextAlign.center),
              pw.Text(product.name.toString(), textAlign: pw.TextAlign.center),
              pw.Text('${product.weight} kg', textAlign: pw.TextAlign.center),
              pw.Text('${product.packageWeight} kg',
                  textAlign: pw.TextAlign.center),
              pw.Text(product.numberPackage.toString(),
                  textAlign: pw.TextAlign.center),
              pw.Text(
                  '${(product.weight - (product.packageWeight * product.numberPackage))} kg',
                  textAlign: pw.TextAlign.center),
              pw.Text('${product.price} L.E', textAlign: pw.TextAlign.center),
              pw.Text(
                  '${(product.weight - (product.packageWeight * product.numberPackage)) * product.price} L.E',
                  textAlign: pw.TextAlign.center),
            ],
          ),
      ],
    );
  }
}
