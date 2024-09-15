import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newapp/resources/firestoreMethods.dart';
import 'package:video_player/video_player.dart';

import '../responsive/veiwpdf.dart';

class searchGuideProfile extends StatefulWidget {
  final String uid;
  const searchGuideProfile({Key? key, required this.uid}) : super(key: key);

  @override
  State<searchGuideProfile> createState() => _searchGuideProfileState();
}

class _searchGuideProfileState extends State<searchGuideProfile> {
  String username = '';
  String email = '';
  String person = '';
  String profilePic = '';
  String bio = '';
  String college = '';
  List followers = [];
  int postlength = 0;
  String postfileurl = '';
  bool isload = false;
  String type = 'photoposts';
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    getdetails();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController?.dispose();
  }

  void buttonpressed() {
    if (_videoPlayerController != null) {
      setState(() {
        _videoPlayerController!.value.isPlaying
            ? _videoPlayerController!.pause()
            : _videoPlayerController!.play();
      });
    }
  }

  Future<dynamic> getdetails() async {
    setState(() {
      isload = true;
    });
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('newusers')
        .doc(widget.uid)
        .get();
    var postsnap = await FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: widget.uid)
        .get();

    setState(() {
      postlength = postsnap.docs.length;

      username = (snap.data() as Map<String, dynamic>)["username"];
      person = (snap.data() as Map<String, dynamic>)["person"];
      profilePic = (snap.data() as Map<String, dynamic>)["profilePic"];
      bio = (snap.data() as Map<String, dynamic>)["bio"];
      college = (snap.data() as Map<String, dynamic>)["college"];
      email = (snap.data() as Map<String, dynamic>)["email"];

      followers = (snap.data() as Map<String, dynamic>)["followers"];
      isload = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isload
        ? Center(
            child: CircularProgressIndicator(
            color: Colors.blue,
          ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 139, 64, 251),
              title: Text('Profile', style: TextStyle(fontFamily: 'ananias')),
              centerTitle: false,
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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: CircleAvatar(
                          radius: 49,
                          backgroundImage: NetworkImage(profilePic),
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${person} -',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.03,
                                  color: Colors.greenAccent,
                                  fontFamily: 'ananias'),
                            ),
                            Text(
                              ' ${username}',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.03,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: 'ananias'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.18,
                          width: double.infinity,
                          margin:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(186, 91, 90, 90)),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Bio - $bio',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.022,
                                      color:
                                          Color.fromARGB(255, 218, 216, 216)),
                                ),
                                Text(
                                  'College - $college',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.022,
                                      color:
                                          Color.fromARGB(255, 218, 216, 216)),
                                ),
                                Text('Email - $email',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.022,
                                      color: Color.fromARGB(255, 218, 216, 216),
                                    ))
                              ],
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.008,
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: 3, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromARGB(255, 139, 64, 251),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${followers.length}',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  Text('Followers',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${postlength}',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  Text('Posts',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ],
                              ),
                              InkWell(
                                  onTap: () async {
                                    await firestoreMethods().follow(
                                        FirebaseAuth.instance.currentUser!.uid,
                                        widget.uid,
                                        followers);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: MediaQuery.of(context).size.height *
                                        0.038,
                                    width: MediaQuery.of(context).size.width *
                                        0.23,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color:
                                            Color.fromARGB(255, 87, 197, 143)),
                                    child: followers.contains(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        ? Text('Unfollow',
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white))
                                        : Text('Follow',
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                  )),
                            ],
                          )),
                      Divider(
                        color: Colors.white,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    type = 'photoposts';
                                  });
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: type == 'photoposts'
                                          ? Color.fromARGB(255, 139, 64, 251)
                                          : Color.fromARGB(186, 91, 90, 90),
                                    ),
                                    child: Text('Photos',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.025,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)))),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    type = 'booksposts';
                                  });
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: type == 'booksposts'
                                          ? Color.fromARGB(255, 139, 64, 251)
                                          : Color.fromARGB(186, 91, 90, 90),
                                    ),
                                    child: Text('Books',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.025,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)))),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    type = 'formulabookposts';
                                  });
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: type == 'formulabookposts'
                                          ? Color.fromARGB(255, 139, 64, 251)
                                          : Color.fromARGB(186, 91, 90, 90),
                                    ),
                                    child: Text('Formula',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.025,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)))),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    type = 'otherposts';
                                  });
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: type == 'otherposts'
                                          ? Color.fromARGB(255, 139, 64, 251)
                                          : Color.fromARGB(186, 91, 90, 90),
                                    ),
                                    child: Text('others',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.025,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)))),
                          ]),
                      FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection(type)
                              .where('uid', isEqualTo: widget.uid)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              );
                            }
                            return SingleChildScrollView(
                              child: GridView.builder(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      (snapshot.data! as dynamic).docs.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    childAspectRatio: 0.9,
                                  ),
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot snap =
                                        (snapshot.data! as dynamic).docs[index];

                                    if (snap['type'] == 'Photo') {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Color.fromARGB(
                                                  186, 91, 90, 90),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 17,
                                                      backgroundImage:
                                                          NetworkImage(snap[
                                                              'profilePic']),
                                                    ),
                                                    Expanded(
                                                        child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 16.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                snap[
                                                                    'username'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Text(
                                                                  snap[
                                                                      'college'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          218,
                                                                          216,
                                                                          216)))
                                                            ],
                                                          ),
                                                          Text(
                                                              '~ ${snap['person']}',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .greenAccent))
                                                        ],
                                                      ),
                                                    )),
                                                    IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  Dialog(
                                                                      child:
                                                                          Container(
                                                                    height: 45,
                                                                    child:
                                                                        ListView(
                                                                      children: [
                                                                        'Report'
                                                                      ]
                                                                          .map((e) =>
                                                                              InkWell(
                                                                                onTap: () {},
                                                                                child: Container(
                                                                                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 17),
                                                                                  child: Text(e),
                                                                                ),
                                                                              ))
                                                                          .toList(),
                                                                    ),
                                                                  )));
                                                        },
                                                        icon: Icon(Icons
                                                            .more_vert_rounded),
                                                        color: Colors.white)
                                                  ],
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  margin: EdgeInsets.only(
                                                      bottom: 10, top: 10),
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: snap[
                                                              'additionalText'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12))),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.37,
                                                  width: double.infinity,
                                                  child: Image.network(
                                                    snap['postfileurl'],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            DateFormat.yMMMd()
                                                                .format(snap[
                                                                        'date']
                                                                    .toDate()),
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        184,
                                                                        184,
                                                                        184)),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Color.fromARGB(
                                                  186, 91, 90, 90),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 17,
                                                      backgroundImage:
                                                          NetworkImage(snap[
                                                              'profilePic']),
                                                    ),
                                                    Expanded(
                                                        child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 16.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                snap[
                                                                    'username'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Text(
                                                                  snap[
                                                                      'college'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          218,
                                                                          216,
                                                                          216)))
                                                            ],
                                                          ),
                                                          Text(
                                                              '~ ${snap['person']}',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .greenAccent))
                                                        ],
                                                      ),
                                                    )),
                                                    IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  Dialog(
                                                                      child:
                                                                          Container(
                                                                    height: 45,
                                                                    child:
                                                                        ListView(
                                                                      children: [
                                                                        'Report'
                                                                      ]
                                                                          .map((e) =>
                                                                              InkWell(
                                                                                onTap: () {},
                                                                                child: Container(
                                                                                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 17),
                                                                                  child: Text(e),
                                                                                ),
                                                                              ))
                                                                          .toList(),
                                                                    ),
                                                                  )));
                                                        },
                                                        icon: Icon(Icons
                                                            .more_vert_rounded),
                                                        color: Colors.white)
                                                  ],
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  margin: EdgeInsets.only(
                                                      bottom: 10, top: 10),
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: snap[
                                                              'additionalText'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12))),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 7),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Color.fromARGB(
                                                        255, 92, 91, 91),
                                                  ),
                                                  height: 100,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .file_copy_outlined,
                                                        color: Colors.white,
                                                        size: 70,
                                                      ),
                                                      Text(snap['type'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'ananias',
                                                              letterSpacing: 2,
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      117,
                                                                      245,
                                                                      252))),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      DateFormat.yMMMd().format(
                                                          snap['date']
                                                              .toDate()),
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              184,
                                                              184,
                                                              184)),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        loadpdf(
                                                                          url: snap[
                                                                              'postfileurl'],
                                                                        )));
                                                      },
                                                      icon: Icon(Icons
                                                          .remove_red_eye_sharp),
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  }),
                            );
                          }),
                    ]),
              ),
            ));
  }
}
