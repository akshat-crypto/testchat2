import 'package:chat2/pdfview.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfFile extends StatelessWidget {
  final ref = FirebaseDatabase.instance.reference().child("PDFInfo").once();

  String year;
  String branch;
  PdfFile({this.year, this.branch});
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
                print (ref);
                print("year is: $year \n Branch is: $branch");
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

// class PdfFile extends StatefulWidget {
//   // @required
//   // String year;
//   // @required
//   // String branch;
//   // PdfFile({this.year, this.branch});
//   @override
//   _PdfFileState createState() => _PdfFileState();
// }

// class _PdfFileState extends State<PdfFile> {
//   String branch;
//   String year;
//   _PdfFileState({this.year, this.branch});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Resources'), backgroundColor: Colors.grey),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             ListTile(
//               title: Text('TestPdf'),
//               onLongPress: () {
//                 print("year is: $year \n Branch is: $branch");
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: Text('Select option'),
//                     actions: [
//                       FlatButton(
//                         onPressed: () async {
//                           // Navigator.push(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //         builder: (context) => PdfView()))
//                           Navigator.pop(context);
//                           await Navigator.of(context).push(
//                               new MaterialPageRoute(
//                                   builder: (context) => PdfView()));
//                         },
//                         child: Text('View'),
//                       ),
//                       FlatButton(
//                         onPressed: () => {},
//                         child: Text('Download'),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
