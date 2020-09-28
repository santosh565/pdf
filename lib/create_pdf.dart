import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_viewer/pdfPreview.dart' as ppdf;
import 'package:printing/printing.dart';

class CreatePDF extends StatefulWidget {
  @override
  _CreatePDFState createState() => _CreatePDFState();
}

class _CreatePDFState extends State<CreatePDF> {
  String _valueName = '';
  String _valuePlace = '';
  final myController = TextEditingController();
  final mySController = TextEditingController();

  void reset() {
    myController.clear();
    mySController.clear();
    _valueName = '';
    _valuePlace = '';
  }

  @override
  void dispose() {
    myController.dispose();
    mySController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    generatePDF() async {
      final pw.Document pdf = pw.Document();
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(32),
          build: (pw.Context context) => [
            pw.Text(
              _valueName,
              style: pw.TextStyle(fontSize: 50),
            ),
            pw.Text(
              _valuePlace,
              style: pw.TextStyle(fontSize: 50),
            ),
          ],
        ),
      );

      final String dir = (await getApplicationDocumentsDirectory()).path;
      print(dir);
      final String path = '$dir/test_pdf.pdf';
      final File file = File(path);
      await file.writeAsBytes(pdf.save());

      /*  await Printing.sharePdf(bytes: pdf.save(), filename: 'my-document.pdf'); */

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ppdf.PdfPreview(
            pathPDF: path,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('PDF'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  controller: myController,
                  onChanged: (value) {
                    _valueName = myController.text;
                    debugPrint(myController.text);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  controller: mySController,
                  onChanged: (value) {
                    _valuePlace = mySController.text;
                    debugPrint(mySController.text);
                  },
                ),
              ),
              RaisedButton(
                onPressed: generatePDF,
                child: Text('Show Pdf'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    reset();
                  });
                },
                child: Text('Reset'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
