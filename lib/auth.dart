//import 'package:chat1/helperfunctions/sharedpref.dart';
//import 'package:chat1/services/databases.dart';
import 'package:chat2/sharedpref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

import 'home.dart';

//import '../home.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return await auth.currentUser;
  }
  


  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    UserCredential result =
        await _firebaseAuth.signInWithCredential(credential);

    User userDetails = result.user;
    //to get user details

    //now to store the user google account data to our firestore data
    if (result != null) {
      String email = result.user.email;
      String userName =
          result.user.email.toString().replaceAll('@gmail.com', '');
      String name = result.user.displayName;
      String imageUrl = result.user.photoURL;
      // SharedPreferenceHelper().saveUserEmail(userDetails.email);
      // SharedPreferenceHelper().saveUserId(userDetails.uid);
      // SharedPreferenceHelper()
      //     .saveUserName(userDetails.email.replaceAll("@gmail.com", ""));
      // // .saveUserName(userDetails.email.contains("@je"))
      // SharedPreferenceHelper().saveDisplayName(userDetails.displayName);
      // SharedPreferenceHelper().saveUserProfileUrl(userDetails.photoURL);

      Map<String, dynamic> userInfoMap = {
        "email": email,
        //replace the @gmail.com part
        "username": userName,
        "name": name,
        "imgUrl": imageUrl
      };
      // if (!userDetails.email.contains('@mnit.ac.in')) {
      //   FirebaseAuth.instance.currentUser.delete();
      //   FirebaseAuth.instance.signOut();
      //   _googleSignIn.signOut();

      //   Fluttertoast.showToast(msg: 'You are not autherized to login');
      //   return;
      // }
      FirebaseDatabase.instance
          .reference()
          .child('UserInformation')
          .child(result.user.uid)
          .update(userInfoMap)
          .then((value) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      });

      /*
      DatabaseMethods()
          .addUserInfoToDB(userDetails.uid, userInfoMap)
          .then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
      */
    }
  }

  signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await auth.signOut();
  }
}
