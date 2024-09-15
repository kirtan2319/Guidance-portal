import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class forAspirant {
  final String email;
  final String uid;
  final String profilePic;
  final String username;
  final String bio;
  final String college;
  final String person;
  final List followers;
  final List following;

  forAspirant(
      {required this.username,
      required this.uid,
      required this.profilePic,
      required this.email,
      required this.bio,
      required this.college,
      required this.person,
      required this.followers,
      required this.following});
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "profilePic": profilePic,
        "bio": bio,
        "college": college,
        "person": person,
        "followers": followers,
        "following": following,
      };

  static forAspirant fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return forAspirant(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      profilePic: snapshot["profilePic"],
      bio: snapshot["bio"],
      college: snapshot["college"],
      person: snapshot["person"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }
}
