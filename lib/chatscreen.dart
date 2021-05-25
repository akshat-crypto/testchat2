import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isSearching = false;
  TextEditingController searchUserNameEditingController =
      TextEditingController();

  onSearchButtonClick() {
    isSearching = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                            padding: const EdgeInsets.only(right: 14),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
