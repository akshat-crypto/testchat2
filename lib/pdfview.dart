import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatefulWidget {
  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('PDFNAME'),
      ),
      body: SfPdfViewer.network(
        "https://drive.google.com/uc?export=download&id=1Jr3SlY0RvbX2bHW3ZYDC3FJhS9YcMTjq",
        // key: _pdfViewerKey,
      ),
    );
  }
}
