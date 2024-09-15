import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newapp/ui/chat_screen.dart';
import 'package:newapp/ui/loginpage.dart';
import 'package:newapp/widgets/photoposting.dart';

import '../widgets/hamburger.dart';

class contentPage extends StatefulWidget {
  contentPage({Key? key}) : super(key: key);

  @override
  State<contentPage> createState() => _contentPageState();
}

class _contentPageState extends State<contentPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("quit button pressed");
        final shouldpop = await showWarning(context);

        return shouldpop??false;
      },
      child: Scaffold(
        drawer: Hamburger(),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 139, 64, 251),
          centerTitle: true,
          title: Text(
            'Feed',
            style: TextStyle(fontFamily: 'ananias'),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ChatScreen()));
                },
                icon: const Icon(Icons.chat_bubble_outlined))
          ],
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/backgroundimg.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .orderBy('date', descending: true)
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => photoPosting(
                  snap: snapshot.data!.docs[index].data(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) =>  AlertDialog(
            title: Text("Do you want to exit the app?"),
            actions: [
              ElevatedButton(
                onPressed: ()=>Navigator.pop(context, false), child: const Text("No")),
              ElevatedButton(child: Text("Yes"), onPressed: ()=>Navigator.pop(context, true), )
            ],
          )
          );
}
