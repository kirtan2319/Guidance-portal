import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

showSnackBAr(String content,context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

pickPhoto(ImageSource source) async {
  final ImagePicker _photoPicker = ImagePicker();
  XFile? _file = await _photoPicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print("No photo selected");


  
}
