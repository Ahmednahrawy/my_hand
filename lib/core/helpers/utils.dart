import 'package:flutter/services.dart';
import 'package:my_hand/features/orderscreen/ui/widgets/pw_data_table.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:my_hand/features/data/models/product_model.dart';

Future<Uint8List> generatePDF(
  final PdfPageFormat format,
  List<Product> products,
  String customerName,
  final double totalCost,
  final double paid,
  final double rest,
  final String? formattedDate,
) async {
  final doc = Document(
    title: 'فاتورة العميل',
    compress: true,
  );
  final loadImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/khayrat_logoo.png'))
          .buffer
          .asUint8List());
  final arabicFont = await rootBundle.load("assets/fonts/Almarai-Regular.ttf");
  final ttf = pw.Font.ttf(arabicFont);

  final pageTheme = await _myPageTheme(format);
  doc.addPage(
    MultiPage(
      pageTheme: pageTheme,
      header: (final context) => pw.Image(
          alignment: pw.Alignment.topLeft,
          loadImage,
          fit: pw.BoxFit.contain,
          width: 140),
      build: (final context) => [
        pw.Container(
          padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('إدارة : ',
                            textDirection: pw.TextDirection.rtl),
                        pw.Text('ت : ', textDirection: pw.TextDirection.rtl),
                      ]),
                  pw.SizedBox(width: 50),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'مهدي إسماعيل قدورة',
                        textDirection: pw.TextDirection.rtl,
                      ),
                      pw.Text('+20 109 094 0051'),
                    ],
                  ),
                  pw.SizedBox(width: 70),
                  pw.BarcodeWidget(
                      data:
                          'https://www.facebook.com/profile.php?id=100084492852878',
                      width: 40,
                      height: 40,
                      barcode: pw.Barcode.qrCode(),
                      drawText: false),
                  pw.Padding(padding: pw.EdgeInsets.zero)
                ],
              ),
            ],
          ),
        ),
        pw.Center(
          child: pw.Column(
            children: [
              pw.Text(
                ' إسم العميل: $customerName ',
                textDirection: pw.TextDirection.rtl,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    fontSize: 30, fontWeight: pw.FontWeight.bold, font: ttf),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                '  التاريخ: $formattedDate ',
                textDirection: pw.TextDirection.rtl,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.normal, font: ttf),
              ),
            ],
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Container(
            height: 400,
            alignment: pw.Alignment.center,
            child: PdfMyDataTable(products: products, totalCost: totalCost),
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Text('إجمالي الفاتورة : \n $totalCost L.E',
                style: const pw.TextStyle(fontSize: 20)),
            pw.Text(
              'تحصيل : \n $paid',
              style: const pw.TextStyle(fontSize: 20),
            ),
            pw.Text(
              'الباقي : \n $rest',
              style: const pw.TextStyle(fontSize: 20),
            )
          ],
        ),
      ],
    ),
  );
  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final arabicFont = await rootBundle.load("assets/fonts/Almarai-Regular.ttf");
  final ttf = pw.Font.ttf(arabicFont);

  return pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    theme: pw.ThemeData.withFont(
      base: ttf,
    ),
    margin: const pw.EdgeInsets.symmetric(
        horizontal: 1 * PdfPageFormat.cm, vertical: 0.5 * PdfPageFormat.cm),
    textDirection: pw.TextDirection.rtl,
    orientation: pw.PageOrientation.portrait,
  );
}

// Future<void> saveAsFile(
//   final BuildContext context,
//   final LayoutCallback build,
//   final PdfPageFormat pageFormat,
// ) async {
//   final bytes = await build(pageFormat);
//   final appDocDir = await getApplicationDocumentsDirectory();
//   final appDocPath = appDocDir.path;
//   final file = File('$appDocPath/document.pdf');
//   print('save as file ${file.path}...');
//   await file.writeAsBytes(bytes);
//   // await OpenFile.open(file.path);
// }

// void showPrintedToast(final BuildContext context) {
//   ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('document printed successfully')));
// }

// void showSharedToast(final BuildContext context) {
//   ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('document shared successfully')));
// }
