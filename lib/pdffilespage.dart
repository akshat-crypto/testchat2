import 'package:chat2/pdfview.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfFile extends StatefulWidget {
  @override
  _PdfFileState createState() => _PdfFileState();
}

class _PdfFileState extends State<PdfFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Resources'), backgroundColor: Colors.grey),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text('TestPdf'),
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Select option'),
                    actions: [
                      FlatButton(
                        onPressed: () async {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => PdfView()))
                          Navigator.pop(context);
                          await Navigator.of(context).push(
                              new MaterialPageRoute(
                                  builder: (context) => PdfView()));
                        },
                        child: Text('View'),
                      ),
                      FlatButton(
                        onPressed: () => {},
                        child: Text('Download'),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
