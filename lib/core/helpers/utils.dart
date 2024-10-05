import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_hand/features/data/models/product_model.dart';
import 'package:my_hand/features/orderscreen/ui/widgets/pw_data_table.dart';

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
      (await rootBundle.load('assets/images/khayray-logo-test-min.png'))
          .buffer
          .asUint8List());
  final arabicFont = await rootBundle.load("assets/fonts/Almarai-Regular.ttf");
  final ttf = pw.Font.ttf(arabicFont);

  // Retrieve the last serial number and increment it
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int invoiceSerial = (prefs.getInt('invoice_serial') ?? 0) + 1;
  await prefs.setInt(
      'invoice_serial', invoiceSerial); // Store the new serial number

  final pageTheme = await _myPageTheme(format);
  doc.addPage(
    MultiPage(
      pageTheme: pageTheme,
      header: (final context) => pw.Image(
          alignment: pw.Alignment.topLeft,
          loadImage,
          fit: pw.BoxFit.contain,
          width: 100),
      build: (final context) => [
        pw.Container(
          padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
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
                  pw.SizedBox(width: 40),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'مهدي إسماعيل قدورة',
                        textDirection: pw.TextDirection.rtl,
                      ),
                      pw.Text('+20 1557435130'),
                    ],
                  ),
                  pw.SizedBox(width: 70),
                  pw.BarcodeWidget(
                      data:
                          'https://www.facebook.com/profile.php?id=100084492852878',
                      width: 50,
                      height: 50,
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
                '  رقم الفاتورة: $invoiceSerial ',
                textDirection: pw.TextDirection.rtl,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.normal, font: ttf),
              ),
              pw.SizedBox(height: 5),
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
            // height: 400,
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
      // maxPages: 100,
        
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
