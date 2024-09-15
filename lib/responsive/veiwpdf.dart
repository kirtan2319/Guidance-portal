import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class loadpdf extends StatefulWidget {
  final String url;

  loadpdf({Key? key, required this.url}) : super(key: key);

  @override
  State<loadpdf> createState() => _loadpdfState();
}

class _loadpdfState extends State<loadpdf> {
  PdfViewerController? _pdfViewerController;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.url);
    return Scaffold(
      appBar: AppBar(
        title: Text('pdf'),
      ),
      body: SfPdfViewer.network(
        widget.url,
        controller: _pdfViewerController,
      ),
    );
  }
}
