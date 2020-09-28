import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class PdfPreview extends StatelessWidget {
  final String pathPDF;

  const PdfPreview({Key key, this.pathPDF}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      path: pathPDF,
    );
  }
}
