import 'package:chat2/detailform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isGoogleLogging = false;

  void _signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final firebaseAuth = FirebaseAuth.instance;
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      setState(() {
        _isGoogleLogging = true;
      });

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      final user = (await firebaseAuth.signInWithCredential(credential)).user;
      print(user);
      await FirebaseDatabase.instance
          .reference()
          .child("User Information")
          .child(FirebaseAuth.instance.currentUser.uid)
          .update({
        "name": googleUser.displayName,
        "email": googleUser.email,
        "imageURL": googleUser.photoUrl,
        "userName": googleUser.email.toString().replaceAll('@gmail.com', ''),
        "branchname": null,
        "yearnumber": null,
        "SMP": null,
      });

      if (user != null) {
        final data = await FirebaseDatabase.instance
            .reference()
            .child('UserInformation')
            .child(FirebaseAuth.instance.currentUser.uid)
            .once();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DetailForm()));
        // if (data.value['branchname'] == null) {
        //   Navigator.of(context).pushReplacement(
        //       MaterialPageRoute(builder: (context) => DetailForm()));
        //   return;
        // }
        setState(() {
          _isGoogleLogging = false;
        });

        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => Home(),
        //   ),
        // );
      } else {
        setState(() {
          _isGoogleLogging = false;
        });
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    } catch (e) {
      print(e);
      setState(() {
        _isGoogleLogging = false;
      });
      print("------------------------");
      print(e);
      print("------------------------");
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('360VirtualSMP'),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image(
              image: AssetImage('images/logo1.jpg'),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white.withOpacity(0.8),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(80),
                    image: DecorationImage(
                      image: AssetImage('images/logo1.jpg'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  alignment: Alignment.center,
                  //color: Colors.blue,
                  child: Text(
                    '360 Virtual India\n in Association With\n MNIT SMPs',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () {
                    _signInWithGoogle();
                  },
                  color: Colors.grey,
                  child: _isGoogleLogging
                      ? SpinKitThreeBounce(
                          color: Colors.white,
                        )
                      : Text(
                          'SIGNIN WITH GOOGLE',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
