import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class gifts extends StatefulWidget {
  const gifts({Key? key}) : super(key: key);

  @override
  State<gifts> createState() => _giftsState();
}

class _giftsState extends State<gifts> {
  int following = 0;
  String posts = '';
  int postlength = 0;
  double ratio = 1;
  String displayratio = '';
  void initState() {
    super.initState();
    getdetails();
  }

  Future<dynamic> getdetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('newusers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    var postsnap = await FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    postlength = postsnap.docs.length;

    setState(() {
      postlength = postsnap.docs.length;

      following = (snap.data() as Map<String, dynamic>)["following"].length;
      ratio = following / postlength;
      displayratio = ratio.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Rewards', style: TextStyle(fontFamily: 'ananias')),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Rewards are calculated based on likes/posts ratio',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.height * 0.024,
                    fontFamily: 'ananias')),
            Text('Your  current ratio is : $displayratio',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.height * 0.022,
                    fontFamily: 'ananias')),
            Divider(
              color: Colors.white,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text(
                'Ratio>5',
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(186, 91, 90, 90)),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ratio > 5
                      ? Colors.white
                      : Color.fromARGB(186, 91, 90, 90)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Amazon coupon worth 50 Rupees',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: ratio > 5 ? Colors.black : Colors.white),
                  ),
                  InkWell(
                    onTap: (() {}),
                    child: Text(
                      'click to redeem',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 126, 124, 124)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(
                'Ratio>10',
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(186, 91, 90, 90)),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ratio > 10
                      ? Colors.white
                      : Color.fromARGB(186, 91, 90, 90)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Amazon coupon worth 100 Rupees',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: ratio > 10 ? Colors.black : Colors.white),
                  ),
                  InkWell(
                    onTap: (() {}),
                    child: Text(
                      'click to redeem',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 126, 124, 124)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
