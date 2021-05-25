import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:profanity_filter/profanity_filter.dart';

import '../main.dart';
import 'models/chartRoom.dart';
import 'models/userInfoModel.dart';

// ignore: must_be_immutable
class SocialMediaChat extends StatefulWidget {
  String uid;
  UserInformation data;
  SocialMediaChat({this.uid, this.data});
  @override
  _SocialMediaChatState createState() => _SocialMediaChatState();
}

class _SocialMediaChatState extends State<SocialMediaChat> {
  List<ChatModel> list;
  var key;
  ChatModel data;
  TextEditingController messageController = TextEditingController();
  String uid;

  void stream() {
    // ignore: unused_local_variable
    final user = FirebaseAuth.instance.currentUser;

    final ref = FirebaseDatabase.instance
        .reference()
        .child("ChatRoomPersonal")
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(widget.uid)
        .onValue;
    ref.listen((event) {
      if (event.snapshot.value == null) {
        return;
      }
      final chatdata = event.snapshot.value as Map;

      list = [];
      chatdata.forEach((key, value) {
        list.add(
          ChatModel(
            uid: value['uid'],
            message: value['message'],
            dateTime: DateTime.parse(
              value['timeStamp'],
            ),
            imageURL: value['DpURL'],
            messageID: key,
          ),
        );
      });
      if (this.mounted && context != null) {
        setState(() {
          list.sort((a, b) => a.dateTime.compareTo(b.dateTime));
          final temp = list.reversed;
          list = [];
          temp.forEach((element) {
            list.add(element);
          });
        });
      }
    });
  }

  UserInformation userInfo;
  initState() {
    // audioModule.setCallBack((dynamic data) {
    //   _onEvent(data);
    // });
    //   _initSettings();
    // userInfo =
    //     Provider.of<UserInfo>(context, listen: false)
    // uid = userInfo.id;
    userInfo = widget.data;
    stream();
    super.initState();
  }

  sendMessage() async {
    final filter = ProfanityFilter();
    final ref = FirebaseDatabase.instance.reference().child("ChatRoomPersonal");
    final key = ref.push().key;
    ref
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(widget.uid)
        .child(key)
        .update({
      'message': filter.censor('${messageController.text}'),
      "uid": userInfo.id,
      "timeStamp": DateTime.now().toIso8601String(),
      'Name': userInfo.name,
      "DpURL": userInfo.imageUrl,
    });

    ref
        .child(widget.uid)
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(key)
        .update({
      'message': filter.censor('${messageController.text}'),
      "uid": userInfo.id,
      "timeStamp": DateTime.now().toIso8601String(),
      'Name': userInfo.name,
      "DpURL": userInfo.imageUrl,
    });

    FirebaseDatabase.instance
        .reference()
        .child("PersonalChatsPersons")
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(widget.uid)
        .update({"imageURL": widget.data.imageUrl, "name": widget.data.name});
    FirebaseDatabase.instance
        .reference()
        .child("PersonalChatsPersons")
        .child(widget.uid)
        .child(FirebaseAuth.instance.currentUser.uid)
        .update({"imageURL": userInfo.imageUrl, "name": userInfo.name});
    messageController.text = '';
  }

  Widget chatMessageList() {
    return list != null
        ? Container(
            child: ListView.builder(
                reverse: true,
                itemCount: list.length,
                itemBuilder: (context, index) => MessageTile(
                      message: list[index].message,
                      isSendByMe: list[index].uid == userInfo.id,
                      imageURL: list[index].imageURL,
                      name: list[index].nameOfCustomer,
                      id: list[index].messageID,
                    )),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // bottomNavigationBar:
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.grey,
            title: InkWell(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => SocialMediaProfileScreen(
                  //       uid: widget.data.id,
                  //       isme: false,
                  //     ),
                  //   ),
                  // );
                },
                child: Text('${widget.data.name}')),
          ),
          body: Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage(
            //       "assets/chat-background.jpeg",
            //     ),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: Column(
              children: [
                Expanded(
                  child: chatMessageList(),
                ),
                Container(
                  color: Colors.teal,
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .8,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 15,
                            top: 10,
                            bottom: 10,
                          ),
                          child: TextField(
                            style: TextStyle(fontSize: 16),
                            controller: messageController,
                            onChanged: (val) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Start Typing....',
                              hintStyle: TextStyle(fontSize: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              fillColor: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .03,
                      ),
                      InkWell(
                        onTap: () {
                          if (messageController.text == null ||
                              messageController.text == "") {
                            Fluttertoast.showToast(
                                msg: "Write some message!",
                                gravity: ToastGravity.BOTTOM);
                            return;
                          }
                          return sendMessage();
                        },
                        child: messageController.text == null ||
                                messageController.text == ""
                            ? Text(
                                'Send',
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Icon(
                                Icons.send,
                                color: Colors.blue,
                              ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .05,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  //audio system

  // bool _isRecording = false;

  bool canRecord = false;
  double recordPower = 0.0;
  double recordPosition = 0.0;
  bool isRecord = false;
  bool isPlay = false;
  double playPosition = 0.0;
  String file = "";
  var filePATH = "";
  bool isAudioSystemON = false;
}

// ignore: must_be_immutable
class MessageTile extends StatefulWidget {
  final bool isSendByMe;
  final String message;
  final String imageURL;
  String name;
  final String id;

  MessageTile({
    this.isSendByMe,
    this.message,
    this.imageURL,
    this.name,
    this.id,
  });

  @override
  _MessageTileState createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  // bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(
          left:
              widget.isSendByMe ? MediaQuery.of(context).size.width * .25 : 15,
          right:
              widget.isSendByMe ? 15 : MediaQuery.of(context).size.width * .2),
      width: MediaQuery.of(context).size.width,
      alignment:
          widget.isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.isSendByMe ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: widget.isSendByMe
                          ? Radius.circular(15)
                          : Radius.circular(0),
                      bottomRight: widget.isSendByMe
                          ? Radius.circular(0)
                          : Radius.circular(15)),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(right: 15, left: 15, bottom: 10, top: 12),
                  child: widget.isSendByMe
                      ? Row(
                          children: [
                            // widget.message.contains(".mp3")
                            //     ? GestureDetector(
                            //         child: isPlaying
                            //             ? Icon(Icons.pause)
                            //             : Icon(Icons.play_arrow),
                            //         onTap: () {
                            //           if (isPlaying) {
                            //             setState(() {
                            //               isPlaying = false;
                            //               //   pauseAudio();
                            //             });
                            //           } else {
                            //             setState(() {
                            //               isPlaying = true;
                            //             });
                            //             //    play(widget.message);
                            //           }
                            //         })
                            //     :
                            Container(
                              width: width * 0.61,
                              child: Text(
                                widget.message,
                                textAlign: widget.isSendByMe
                                    ? TextAlign.left
                                    : TextAlign.left,
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            // widget.message.contains(".mp3")
                            //     ? Container(
                            //         width: MediaQuery.of(context).size.width *
                            //             0.46,
                            //         child: slider(),
                            //       )
                            //     : Container(),
                          ],
                        )
                      : Row(
                          children: [
                            // widget.message.contains(".mp3")
                            //     ? GestureDetector(
                            //         child: isPlaying
                            //             ? Icon(Icons.pause)
                            //             : Icon(Icons.play_arrow),
                            //         onTap: () {
                            //           if (isPlaying) {
                            //             setState(() {
                            //               isPlaying = false;
                            //               //    pauseAudio();
                            //             });
                            //           } else {
                            //             setState(() {
                            //               isPlaying = true;
                            //             });
                            //             //   play(widget.message);
                            //           }
                            //         })
                            //     :
                            Container(
                              width: width * 0.5,
                              child: Text(
                                widget.message,
                                textAlign: widget.isSendByMe
                                    ? TextAlign.left
                                    : TextAlign.left,
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            // widget.message.contains(".mp3")
                            //     ? Container(
                            //         width: MediaQuery.of(context).size.width *
                            //             0.46,
                            //         child: slider(),
                            //       )
                            //     : Container(),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
