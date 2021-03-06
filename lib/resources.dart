import 'package:chat2/pdffilespage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResourcesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Resources'),
          backgroundColor: Colors.grey,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Select the Year: ',
                style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              ListTile(
                //leading: Icon(Icons.),
                title: Text('1st Year'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BranchName(
                        year: 1,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                //leading: Icon(Icons.),
                title: Text('2nd Year'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BranchName(
                                year: 2,
                              )));
                },
              ),
              ListTile(
                //leading: Icon(Icons.),
                title: Text('3rd Year'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BranchName(year: 3)));
                },
              ),
              ListTile(
                //leading: Icon(Icons.),
                title: Text('4th Year'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BranchName(year: 4)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BranchName extends StatelessWidget {
  @required
  int year;
  BranchName({this.year});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Resources'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Select the Branch: ',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              //leading: Icon(Icons.),
              title: Text('Computer Science Engineering'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PdfFile(
                              year: "$year",
                              branch: "CSE",
                            )));
              },
            ),
            ListTile(
              //leading: Icon(Icons.),
              title: Text('Mechanical Engineering'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfFile(
                      year: "$year",
                      branch: "ME",
                    ),
                  ),
                );
              },
            ),
            ListTile(
              //leading: Icon(Icons.),
              title: Text('Electrical Engineering'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfFile(
                      year: "$year",
                      branch: "ECE",
                    ),
                  ),
                );
              },
            ),
            ListTile(
              //leading: Icon(Icons.),
              title: Text('Information Technology'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfFile(
                      year: "$year",
                      branch: "IT",
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
// class ResourcesPage extends StatefulWidget {
//   @override
//   _ResourcesPageState createState() => _ResourcesPageState();
// }

// class _ResourcesPageState extends State<ResourcesPage> {
//   final int year = 0;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Resources'),
//           backgroundColor: Colors.grey,
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 30,
//               ),
//               Text(
//                 'Select the Year: ',
//                 style: GoogleFonts.lato(
//                     color: Colors.black,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               ListTile(
//                 //leading: Icon(Icons.),
//                 title: Text('1st Year'),
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => BranchName()));
//                 },
//               ),
//               ListTile(
//                 //leading: Icon(Icons.),
//                 title: Text('2nd Year'),
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => BranchName()));
//                 },
//               ),
//               ListTile(
//                 //leading: Icon(Icons.),
//                 title: Text('3rd Year'),
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => BranchName()));
//                 },
//               ),
//               ListTile(
//                 //leading: Icon(Icons.),
//                 title: Text('4th Year'),
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => BranchName()));
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BranchName extends StatefulWidget {
//   @override
//   _BranchNameState createState() => _BranchNameState();
// }

// class _BranchNameState extends State<BranchName> {
//   int year;
//   String branch;

//   ({this.year; this. branch;})

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey,
//         title: Text('Resources'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 30,
//             ),
//             Text(
//               'Select the Branch: ',
//               style: GoogleFonts.lato(
//                   color: Colors.black,
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             ListTile(
//               //leading: Icon(Icons.),
//               title: Text('Computer Science Engineering'),
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => PdfFile()));
//               },
//             ),
//             ListTile(
//               //leading: Icon(Icons.),
//               title: Text('Mechanical Engineering'),
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => PdfFile()));
//               },
//             ),
//             ListTile(
//               //leading: Icon(Icons.),
//               title: Text('Electrical Engineering'),
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => PdfFile()));
//               },
//             ),
//             ListTile(
//               //leading: Icon(Icons.),
//               title: Text('Information Technology'),
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => PdfFile()));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
