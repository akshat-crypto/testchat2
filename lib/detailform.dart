import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

class DetailForm extends StatefulWidget {
  @override
  _DetailFormState createState() => _DetailFormState();
}

class _DetailFormState extends State<DetailForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController yearNumberController = TextEditingController();

  var year;
  var branch;

  onYearClicked() {
    setState(() {
      year = yearNumberController.text;
    });
  }

  onBranchedClicked() {
    setState(() {
      branch = branchNameController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('360VirtualSMP'),
          backgroundColor: Colors.grey,
        ),
        body: SingleChildScrollView(
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Enter Your Details',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: yearNumberController,
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.date_range,
                    color: Colors.grey,
                  ),
                  hintText: 'Enter Year Number (Ex 2 for 2nd year students)',
                  labelText: 'YearNumber',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(28.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(28.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                onChanged: (value) {
                  year = value;
                },
                // validator: (year) {
                //   if (year.isEmpty) {
                //     return 'Please enter Year in numbers';
                //   }
                //   return null;
                // },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: branchNameController,
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                  fillColor: Colors.grey,
                  focusColor: Colors.grey,
                  icon: Icon(
                    Icons.bar_chart,
                    color: Colors.grey,
                  ),
                  hintText: 'Enter Branch Name (Ex IT,CSE,ME,ECE)',
                  labelText: 'BranchName',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(28.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(28.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                onChanged: (value) {
                  branch = value;
                  print("branch is ${branch}");
                },
                // validator: (branch) {
                //   if (branch.isEmpty) {
                //     return 'Please enter Branch';
                //   }
                //   return null;
                // },
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.center,
                child: RaisedButton(
                  color: Colors.grey,
                  onPressed: () {
                    print("Branch is ${branch}");
                    print("Year is ${year}");
                    if (branch != null && year != null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    }
                    // if (_formKey.currentState.validate()) {
                    //   // If the form is valid, display a Snackbar.
                    //   // Scaffold.of(context).showSnackBar(
                    //   //     SnackBar(content: Text('Data is in processing.')));
                    //   Navigator.pushReplacement(context,
                    //       MaterialPageRoute(builder: (context) => Home()));
                    // }
                    // Navigator.pushReplacement(
                    //     context, MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
