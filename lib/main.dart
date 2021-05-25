import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth.dart';
import 'home.dart';
import 'signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
var user = auth.currentUser;

//var user2 = AuthMethods().getCurrentUser();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: AuthMethods().getCurrentUser(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            //if (user.uid != null) {
            if (snapshot.hasData) {
              return Home();
            } else {
              return SignIn();
            }
          }),
    );
  }
}
