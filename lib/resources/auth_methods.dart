import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/manage/forAspirant.dart' as manage1;
import 'package:newapp/manage/forGuide.dart' as manage2;
import 'package:newapp/resources/storage.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<dynamic> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('aspirant')
        .doc('aspirant')
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (snap.data() == null) {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('guide')
          .doc('guide')
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      return manage1.forAspirant.fromSnap(snap);
    } else {
      return manage2.forGuide.fromSnap(snap);
    }
  }

  //sign up user
  Future<String> signUpAspirant({
    required String email,
    required String password,
    required String username,
    required String bio,
    required String college,
    required Uint8List file,
    required String person,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          password.isNotEmpty ||
          file != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        String profilePic =
            await StorageMeth().upload_Img("ProfilePics", file, false);
        //add user to database
        manage1.forAspirant _newuser = manage1.forAspirant(
            username: username,
            uid: cred.user!.uid,
            profilePic: profilePic,
            email: email,
            bio: bio,
            college: college,
            person: person,
            followers: [],
            following: []);

        await _firestore
            .collection('newusers')
            .doc(cred.user!.uid)
            .set(_newuser.toJson());
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        // print(cred.user!.uid);

        // //add user to database
        // await _firestore.collection('users').doc(cred.user!.uid).set({
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'followers': [],
        //   'following': [],
        // });
        res = "success";
      } else {
        res = ("Please enter all the fields");
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signout() async {
    _auth.signOut();
  }
}

class secondAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //sign up user
  Future<String> signUpGuide({
    required String email,
    required String password,
    required String username,
    required String college,
    required String bio,
    required String person,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          password.isNotEmpty ||
          college.isNotEmpty ||
          file != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        String profilePic =
            await StorageMeth().upload_Img("ProfilePics", file, false);
        //add user to database

        manage2.forGuide _newuser = manage2.forGuide(
            username: username,
            uid: cred.user!.uid,
            profilePic: profilePic,
            email: email,
            college: college,
            bio: bio,
            person: person,
            followers: [],
            following: []);
        await _firestore
            .collection('newusers')
            .doc(cred.user!.uid)
            .set(_newuser.toJson());

        res = "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == "weak-password") {
        res = "Password should be atleast 6 letters";
      } else if (e.code == "invalid-email") {
        res = "Email Not Found";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = ("Please enter all the fields");
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}


// print(cred.user!.uid);
//           //add user to database
//          await _firestore.collection('users').doc(cred.user!.uid).set({

//             'uid': cred.user!.uid,
//             'email': email,

//             'followers': [],
//             'following': [],
//           });