import 'package:chat2/chatscreen.dart';
import 'package:flutter/material.dart';
import 'package:chat2/drawer.dart';

import 'auth.dart';
import 'signin.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('360VirtualSMP'),
          actions: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.notifications),
            ),
            InkWell(
              onTap: () {
                AuthMethods().signOut().then((s) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.logout),
              ),
            ),
          ],
        ),
        body: HomeBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(),
                ))
          },
          backgroundColor: Colors.white,
          child: Image(
            image: AssetImage('images/mail3.png'),
            height: 130,
            width: 40,
            //height: MediaQuery.of(context).size.height,
            //width: MediaQuery.of(context).size.height,
          ),
        ),
        drawer: SideDrawer(),
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
