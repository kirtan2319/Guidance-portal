import 'dart:io';
import 'dart:typed_data';
import 'package:newapp/resources/firebaseApi.dart';
import 'package:path/path.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageMeth {
  UploadTask? task;

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> upload_Img(
      String childName, Uint8List file, bool isPost) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask _uploadTAsk = ref.putData(file);
    TaskSnapshot snap = await _uploadTAsk;

    String downloadURL = await snap.ref.getDownloadURL();
    return downloadURL;
  }

  Future upload_File(File file) async {
    if (file == null) return;
    final fileName = basename(file.path);
    final destination = 'files/$fileName';
    task = FirebaseApi.uploadFile(destination, file);
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
    print('success');
  }
}
