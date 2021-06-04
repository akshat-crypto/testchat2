import 'package:chat2/SocialMediaChatRoom%20(1).dart';
import 'package:chat2/main.dart';
import 'package:chat2/models/userInfoModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isSearching = false;
  TextEditingController searchUserNameEditingController =
      TextEditingController();

  List<UserInformation> users = [];
  getTotalUsers() async {
    final data = await FirebaseDatabase.instance
        .reference()
        .child('User Information')
        .orderByChild('SMP')
        .equalTo("yes")
        .once();
    // final data = await FirebaseDatabase.instance
    //     .reference()
    //     .child('User Information')
    //     .orderByChild(key)
    if (data.value != null) {
      final mapData = data.value as Map;
      mapData.forEach((key, value) {
        users.add(
          UserInformation(
            id: key,
            imageUrl: value['imageURL'],
            email: value['email'],
            name: value['name'],
            userName: value['userName'],
            branchname: value['branchname'],
            yearnumber: value['yearnumber'],
            smp: value['SMP'],
          ),
        );
      });
      setState(() {
        users.removeWhere(
          (element) => element.id == FirebaseAuth.instance.currentUser.uid,
        );
      });
    }
  }

  onSearchButtonClick() {
    isSearching = true;
    setState(() {});
  }

  @override
  void initState() {
    getTotalUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  isSearching
                      ? GestureDetector(
                          onTap: () {
                            isSearching = false;
                            //isSearching = true;
                            setState(() {
                              searchUserNameEditingController.text = "";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(Icons.arrow_back),
                          ),
                        )
                      : Container(
                          color: Colors.blue,
                          height: 40,
                        ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              cursorColor: Colors.grey,
                              controller: searchUserNameEditingController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Username",
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (searchUserNameEditingController.text != "") {
                                onSearchButtonClick();
                              }
                            },
                            child: Icon(Icons.search),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: height * .8,
                width: width,
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SocialMediaChat(
                            uid: users[index].id,
                            data: users[index],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            child: Image.network(
                              users[index].imageUrl,
                              height: 35,
                              width: 35,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                users[index].name,
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                users[index].email,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Year: ${users[index].yearnumber}',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Branch: ${users[index].branchname}',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // child: ListTile(
                    //   title: Text(users[index].name),
                    //   subtitle: Text(users[index].email),
                    // ),
                  ),
                ),
              ),
            ],
          ),
          // isSearching ? Center(child: CircularProgressIndicator(),) :
        ),
      ),
    );
  }
}
