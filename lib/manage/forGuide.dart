import 'package:cloud_firestore/cloud_firestore.dart';

class forGuide {
  final String email;
  final String uid;
  final String profilePic;
  final String username;
  final String college;
  final String bio;
  final String person;
  final List followers;
  final List following;

  forGuide(
      {required this.username,
      required this.uid,
      required this.profilePic,
      required this.email,
      required this.college,
      required this.bio,
      required this.person,
      required this.followers,
      required this.following});
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "profilePic": profilePic,
        "college": college,
        "bio": bio,
        "person": person,
        "followers": followers,
        "following": following,
      };
  static forGuide fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return forGuide(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      profilePic: snapshot["profilePic"],
      bio: snapshot["bio"],
      person: snapshot["person"],
      followers: snapshot["followers"],
      following: snapshot["following"],
      college: snapshot["college"],
    );
  }
}
