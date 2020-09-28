import 'package:flutter/material.dart';

import 'package:pdf_viewer/create_pdf.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
      home: CreatePDF(),
    );
  }
}
