import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:newapp/manage/post.dart';
import 'package:newapp/resources/storage.dart';
import 'package:newapp/widgets/selectfile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class firestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String username,
    String uid,
    String profilePic,
    String additionalText,
    String type,
    String college,
    String person,
    Uint8List file,
  ) async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('newusers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    college = (snap.data() as Map<String, dynamic>)["college"];
    person = (snap.data() as Map<String, dynamic>)["person"];
    profilePic = (snap.data() as Map<String, dynamic>)["profilePic"];

    String res = 'some error occured';
    try {
      String postfileurl = await StorageMeth().upload_Img("posts", file, true);
      String postId = const Uuid().v1();
      Post post = Post(
          username: username,
          uid: uid,
          postfileurl: postfileurl,
          college: college,
          person: person,
          type: type,
          profilePic: profilePic,
          date: DateTime.now(),
          additionalText: additionalText,
          likes: [],
          postId: postId);
      _firestore.collection('posts').doc(postId).set(post.toJson());
      _firestore.collection('photoposts').doc(postId).set(post.toJson());

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //upload file as post
  Future<String> uploadFile(
    String username,
    String uid,
    String profilePic,
    String type,
    String additionalText,
    String college,
    String person,
    File file,
  ) async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('newusers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    college = (snap.data() as Map<String, dynamic>)["college"];
    person = (snap.data() as Map<String, dynamic>)["person"];
    profilePic = (snap.data() as Map<String, dynamic>)["profilePic"];

    String res = 'some error occured';
    try {
      String postfileurl = await StorageMeth().upload_File(file);
      String postId = const Uuid().v1();
      Post post = Post(
          username: username,
          uid: uid,
          postfileurl: postfileurl,
          type: type,
          college: college,
          person: person,
          profilePic: profilePic,
          date: DateTime.now(),
          additionalText: additionalText,
          likes: [],
          postId: postId);
      _firestore.collection('posts').doc(postId).set(post.toJson());
      if (type == 'Photo') {
        _firestore.collection('photoposts').doc(postId).set(post.toJson());
      } else if (type == 'Formulabook') {
        _firestore
            .collection('formulabookposts')
            .doc(postId)
            .set(post.toJson());
      } else if (type == 'Books') {
        _firestore.collection('booksposts').doc(postId).set(post.toJson());
      } else if (type == 'Video') {
        _firestore.collection('videoposts').doc(postId).set(post.toJson());
      } else if (type == 'Handwritten notes') {
        _firestore.collection('otherposts').doc(postId).set(post.toJson());
      }
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //updating likes
  Future<String> likePost(
      String postId, String postuseruid, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
        _firestore.collection('newusers').doc(postuseruid).update({
          'following': FieldValue.arrayRemove([uid])
        });
      } else {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
        _firestore.collection('newusers').doc(postuseruid).update({
          'following': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //updating followers
  Future<String> follow(
      String currentuseruid, String uid, List followers) async {
    String res = "Some error occurred";
    try {
      if (followers.contains(currentuseruid)) {
        _firestore.collection('newusers').doc(uid).update({
          'followers': FieldValue.arrayRemove([currentuseruid])
        });
      } else {
        _firestore.collection('newusers').doc(uid).update({
          'followers': FieldValue.arrayUnion([currentuseruid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //comment and answer posting
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic, String person) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
          'person': person,
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

//deleting post
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
