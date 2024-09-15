import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class getDetails {
  Future<dynamic> getdetails(String detail) async {
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
    }
    return snap[detail];
  }
}
