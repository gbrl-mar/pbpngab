import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReceiptPage extends StatelessWidget {
  final String packageName;
  final String price;
  final String date;

  ReceiptPage({
    required this.packageName,
    required this.price,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Receipt')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Receipt',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Package: $packageName', style: TextStyle(fontSize: 18)),
            Text('Price: $price', style: TextStyle(fontSize: 18)),
            Text('Date: $date', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Generate and download the PDF
                await _generateAndPrintPdf(context);
              },
              child: Text('Print PDF'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to generate and print/download the PDF
  Future<void> _generateAndPrintPdf(BuildContext context) async {
    final pdf = pw.Document();

    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Receipt',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Package: $packageName', style: pw.TextStyle(fontSize: 18)),
            pw.Text('Price: $price', style: pw.TextStyle(fontSize: 18)),
            pw.Text('Date: $date', style: pw.TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );

    // Download or display the PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
