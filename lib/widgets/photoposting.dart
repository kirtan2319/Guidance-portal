import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newapp/resources/getdetails.dart';
import 'package:newapp/responsive/commentscreen.dart';
import 'package:newapp/utils/utils.dart';
import 'package:video_player/video_player.dart';

import '../resources/firestoreMethods.dart';
import '../responsive/veiwpdf.dart';

class photoPosting extends StatefulWidget {
  final snap;
  const photoPosting({Key? key, required this.snap}) : super(key: key);

  @override
  State<photoPosting> createState() => _photoPostingState();
}

class _photoPostingState extends State<photoPosting> {
  String uid = '';
  String type = '';
  VideoPlayerController? _videoPlayerController;
  int commentcount = 0;

  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController =
        VideoPlayerController.network(widget.snap['postfileurl'])
          ..initialize().then((_) {
            setState(() {});
          });
    getdetails();
    commentCounter();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController?.dispose();
  }

  void commentCounter() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();

      commentcount = snap.docs.length;
    } catch (err) {
      showSnackBAr(
        err.toString(),
        context,
      );
    }
    setState(() {});
  }

  Future<dynamic> getdetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('newusers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      uid = (snap.data() as Map<String, dynamic>)["uid"];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.snap['type'] == 'Photo') {
      return Column(
        mainAxisSize: MainAxisSize.min,
        
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromARGB(186, 91, 90, 90),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 17,
                      backgroundImage: NetworkImage(widget.snap['profilePic']),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.snap['username'],
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(widget.snap['college'],
                                  style: TextStyle(
                                      fontSize: 11,
                                      color:
                                          Color.fromARGB(255, 218, 216, 216)))
                            ],
                          ),
                          Text('~ ${widget.snap['person']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.greenAccent))
                        ],
                      ),
                    )),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                      child: Container(
                                    height: 45,
                                    child: ListView(
                                      children: ['Report']
                                          .map((e) => InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 13,
                                                      horizontal: 17),
                                                  child: Text(e),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  )));
                        },
                        icon: Icon(Icons.more_vert_rounded),
                        color: Colors.white)
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: RichText(
                      text: TextSpan(
                          text: widget.snap['additionalText'],
                          style: TextStyle(color: Colors.white, fontSize: 14))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.37,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['postfileurl'],
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              await firestoreMethods().likePost(
                                  widget.snap['postId'],
                                  widget.snap['uid'],
                                  uid,
                                  widget.snap['likes']);
                              // print(
                              //   getDetails().getdetails("uid"),
                              // );
                            },
                            icon: Icon(Icons.thumb_up_alt_rounded,
                                color: widget.snap['likes'].contains(uid)
                                    ? Colors.greenAccent
                                    : Colors.white)),
                        Text('${widget.snap['likes'].length}',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => commentScreen(
                                        snap: widget.snap,
                                      )));
                            },
                            icon: Icon(Icons.question_answer_rounded,
                                color: Colors.white)),
                        Text('$commentcount',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          alignment: Alignment.topRight,
                          child: Text(
                            DateFormat.yMMMd()
                                .format(widget.snap['date'].toDate()),
                            style: TextStyle(
                                color: Color.fromARGB(255, 184, 184, 184)),
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      );
    } else if (widget.snap['type'] == 'Formulabook' ||
        widget.snap['type'] == 'Books' ||
        widget.snap['type'] == 'Handwritten notes') {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromARGB(186, 91, 90, 90),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 17,
                      backgroundImage: NetworkImage(widget.snap['profilePic']),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.snap['username'],
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(widget.snap['college'],
                                  style: TextStyle(
                                      fontSize: 10,
                                      color:
                                          Color.fromARGB(255, 218, 216, 216)))
                            ],
                          ),
                          Text('~ ${widget.snap['person']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.greenAccent))
                        ],
                      ),
                    )),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                      child: Container(
                                    height: 45,
                                    child: ListView(
                                      children: ['Report']
                                          .map((e) => InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 13,
                                                      horizontal: 17),
                                                  child: Text(e),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  )));
                        },
                        icon: Icon(Icons.more_vert_rounded),
                        color: Colors.white)
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: RichText(
                      text: TextSpan(
                          text: widget.snap['additionalText'],
                          style: TextStyle(color: Colors.white, fontSize: 14))),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromARGB(255, 92, 91, 91),
                  ),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.file_copy_outlined,
                        color: Colors.white,
                        size: 70,
                      ),
                      Text(widget.snap['type'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ananias',
                              letterSpacing: 1,
                              fontSize: 12,
                              color: Color.fromARGB(255, 117, 245, 252))),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              await firestoreMethods().likePost(
                                  widget.snap['postId'],
                                  widget.snap['uid'],
                                  uid,
                                  widget.snap['likes']);
                              // print(
                              //   getDetails().getdetails("uid"),
                              // );
                            },
                            icon: Icon(Icons.thumb_up_alt_rounded,
                                color: widget.snap['likes'].contains(uid)
                                    ? Colors.greenAccent
                                    : Colors.white)),
                        Text('${widget.snap['likes'].length}',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => commentScreen(
                                        snap: widget.snap,
                                      )));
                            },
                            icon: Icon(Icons.question_answer_rounded,
                                color: Colors.white)),
                        Text('$commentcount',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => loadpdf(
                                        url: widget.snap['postfileurl'],
                                      )));
                        },
                        icon: Icon(Icons.remove_red_eye),
                        color: Colors.white,
                      ),
                    ))
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          alignment: Alignment.topRight,
                          child: Text(
                            DateFormat.yMMMd()
                                .format(widget.snap['date'].toDate()),
                            style: TextStyle(
                                color: Color.fromARGB(255, 184, 184, 184)),
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      );
    } else if (widget.snap['type'] == 'Video') {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromARGB(186, 91, 90, 90),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 17,
                      backgroundImage: NetworkImage(widget.snap['profilePic']),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.snap['username'],
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(widget.snap['college'],
                                  style: TextStyle(
                                      fontSize: 10,
                                      color:
                                          Color.fromARGB(255, 218, 216, 216)))
                            ],
                          ),
                          Text('~ ${widget.snap['person']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.greenAccent))
                        ],
                      ),
                    )),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                      child: Container(
                                    height: 45,
                                    child: ListView(
                                      children: ['Report']
                                          .map((e) => InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 13,
                                                      horizontal: 17),
                                                  child: Text(e),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  )));
                        },
                        icon: Icon(Icons.more_vert_rounded),
                        color: Colors.white)
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: RichText(
                      text: TextSpan(
                          text: widget.snap['additionalText'],
                          style: TextStyle(color: Colors.white, fontSize: 14))),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: _videoPlayerController != null &&
                            _videoPlayerController!.value.isInitialized
                        ? AspectRatio(
                            aspectRatio:
                                _videoPlayerController!.value.aspectRatio,
                            child: VideoPlayer(
                              _videoPlayerController!,
                            ),
                          )
                        : Container(
                            child: Text(
                              "Error...can't load video",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              await firestoreMethods().likePost(
                                  widget.snap['postId'],
                                  widget.snap['uid'],
                                  uid,
                                  widget.snap['likes']);
                              // print(
                              //   getDetails().getdetails("uid"),
                              // );
                            },
                            icon: Icon(Icons.thumb_up_alt_rounded,
                                color: widget.snap['likes'].contains(uid)
                                    ? Colors.greenAccent
                                    : Colors.white)),
                        Text('${widget.snap['likes'].length}',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => commentScreen(
                                        snap: widget.snap,
                                      )));
                            },
                            icon: Icon(Icons.question_answer_rounded,
                                color: Colors.white)),
                        Text('$commentcount',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                    FloatingActionButton(
                      onPressed: buttonpressed,
                      child: Icon(_videoPlayerController != null &&
                              _videoPlayerController!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow_rounded),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          alignment: Alignment.topRight,
                          child: Text(
                            DateFormat.yMMMd()
                                .format(widget.snap['date'].toDate()),
                            style: TextStyle(
                                color: Color.fromARGB(255, 184, 184, 184)),
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
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
}
