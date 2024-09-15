// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/utils/utils.dart';

class ChatRoom extends StatelessWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;

  ChatRoom({required this.chatRoomId, required this.userMap});

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser?.email,
        "message": _message.text,
        "time": FieldValue.serverTimestamp()
      };
      await _firestore
          .collection("chatroom")
          .doc(chatRoomId)
          .collection("chats")
          .add(messages);
      _message.clear();
    } else {
      print("Enter some text");
      // showSnackBAr("Enter some text", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(userMap["username"],
              style: TextStyle(fontFamily: 'ananias')),
          backgroundColor: Color.fromARGB(255, 139, 64, 251),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/backgroundimg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Container(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection("chatroom")
                              .doc(chatRoomId)
                              .collection("chats")
                              .orderBy("time", descending: false)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.data != null) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 20),
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.75,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          Map<String, dynamic> map =
                                              snapshot.data!.docs[index].data()
                                                  as Map<String, dynamic>;
                                          return messages(map);
                                        })),
                              );
                            } else {
                              return Container();
                            }
                          })),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: SizedBox(
                            height: 50,
                            width: 300,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Color.fromARGB(185, 245, 244, 244)),
                              child: TextField(
                                controller: _message,
                                decoration: InputDecoration(
                                    hintText: ("Send Message"),
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 116, 111, 111)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: onSendMessage,
                            icon: Icon(
                              Icons.send,
                              color: Color.fromARGB(255, 183, 81, 243),
                            ))
                      ],
                    ),
                  )
                ],
              )),
        ));
  }

  Widget messages(
    Map<String, dynamic> map,
  ) {
    return Container(
      alignment: map["sendby"] == _auth.currentUser?.email
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(255, 139, 64, 251),
        ),
        child: Text(
          map["message"],
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
