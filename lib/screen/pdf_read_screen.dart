
import 'package:amir/screen/ColorScheme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ReaderScreen extends StatefulWidget {
  final String pdfFile;
  const ReaderScreen({super.key, required this.pdfFile});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pink,
      ),
      body: Container(
        child: SfPdfViewer.network('http://10.0.2.2:3000/${widget.pdfFile}'),
      ),
    );
  }
}
