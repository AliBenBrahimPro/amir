import 'package:amir/models/pdf_model.dart';
import 'package:amir/screen/ColorScheme.dart';
import 'package:amir/screen/pdf_read_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../Services/pdf_service.dart';

class PdfReader extends StatefulWidget {
  String leconId;
  PdfReader({super.key, required this.leconId});

  @override
  State<PdfReader> createState() => _PdfReaderState();
}

class _PdfReaderState extends State<PdfReader> {
  PdfController pdfController = PdfController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              FutureBuilder<List<Pdf>>(
                  future: pdfController.getSpecPdf(widget.leconId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('somthing went wrong ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      final pdf = snapshot.data!;
                      return ListView(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        children: pdf.map((pdfdoc) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReaderScreen(
                                            pdfFile: pdfdoc.file,
                                          )));
                            },
                            title: Text(pdfdoc.title.toString()),
                            subtitle: Text(pdfdoc.subTitle.toString()),
                            leading: Icon(
                              Icons.picture_as_pdf,
                              color: Colors.red,
                              size: 32.0,
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          )
        ],
      )),
    );
  }
}
