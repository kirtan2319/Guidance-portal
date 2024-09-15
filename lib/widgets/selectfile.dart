import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:newapp/responsive/mobilescreen_layout.dart';
import 'package:newapp/utils/utils.dart';
import 'package:path/path.dart';
import '../resources/firebaseApi.dart';
import '../resources/firestoreMethods.dart';
import '../ui/postscreen.dart';

class selectFile extends StatefulWidget {
  selectFile({Key? key}) : super(key: key);

  @override
  State<selectFile> createState() => _selectFileState();
}

class _selectFileState extends State<selectFile> {
  final TextEditingController _addtionalTextController =
      TextEditingController();
  bool _isLoading = false;
  String college = '';
  String person = '';
  String uid = '';
  String type = '';
  String username = '';
  String profilePic = '';
  String? value;
  File? file;
  final items = ['Handwritten notes', 'Formulabook', 'Books', 'Photo', 'Video'];
  DropdownMenuItem<String> buildmenuitem(String item) => DropdownMenuItem(
        value: item,
        alignment: Alignment.center,
        child: Text(
          item,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color.fromARGB(255, 205, 201, 201)),
        ),
      );

  void uploadFile(String uid, String username, String profilePic) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await firestoreMethods().uploadFile(
          username,
          uid,
          profilePic,
          type,
          _addtionalTextController.text,
          college,
          person,
          file!);
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBAr('Posted', context);
        clearPhotoPosting();
      } else {
        showSnackBAr(res, context);
      }
    } catch (e) {
      showSnackBAr(e.toString(), context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdetails();
  }

  void getdetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('newusers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)["username"];
      uid = (snap.data() as Map<String, dynamic>)["uid"];
      profilePic = (snap.data() as Map<String, dynamic>)["profilePic"];
      college = (snap.data() as Map<String, dynamic>)["college"];
      person = (snap.data() as Map<String, dynamic>)["person"];
    });
  }

  void clearPhotoPosting() {
    setState(() {
      file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filename = file != null ? basename(file!.path) : 'No file Selected';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 139, 64, 251),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => AddPost()));
            },
            icon: Icon(Icons.arrow_back)),
        title: const Text(
          'Post ',
          style: TextStyle(fontFamily: 'ananias'),
        ),
        centerTitle: false,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/backgroundimg.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.3,
              //   width: MediaQuery.of(context).size.width * 0.55,
              // child: AspectRatio(
              //   aspectRatio: 250 / 220,
              // child: Container(
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //           fit: BoxFit.contain, image: NetworkImage("")),
              //       )),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.09,
                alignment: Alignment.topLeft,
                child: file != null
                    ? Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                    "https://www.google.com/imgres?imgurl=https%3A%2F%2Ficon-library.com%2Fimages%2Ffile-icon-image%2Ffile-icon-image-5.jpg&imgrefurl=https%3A%2F%2Ficon-library.com%2Ficon%2Ffile-icon-image-5.html&tbnid=cR2MXW9n-0JoZM&vet=10CBoQMyh0ahcKEwj4pKnooMH5AhUAAAAAHQAAAAAQAg..i&docid=q0QwfZKvH6QXMM&w=512&h=512&q=file%20icon&ved=0CBoQMyh0ahcKEwj4pKnooMH5AhUAAAAAHQAAAAAQAg"))))
                    : IconButton(
                        onPressed: fileSelect,
                        icon: Icon(Icons.upload_file_outlined),
                        color: Colors.white,
                        iconSize: 50,
                      ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.008,
              ),

              Text(
                'filename - $filename',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 193, 193, 193)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.001,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.50,
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(8),
                    color: Color.fromARGB(186, 91, 90, 90)),
                child: Theme(
                  data: Theme.of(context).copyWith(canvasColor: Colors.black),
                  child: DropdownButton<String>(
                    hint: Text(
                      "Select type of file",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                        color: Colors.white,
                      ),
                    ),
                    iconDisabledColor: Colors.black,
                    iconEnabledColor: Colors.black,
                    value: value,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    items: items.map(buildmenuitem).toList(),
                    onChanged: (value) => setState(() {
                      this.value = value;
                      type = value!;
                    }),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color.fromARGB(255, 255, 255, 255)),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _addtionalTextController,
                    decoration: const InputDecoration(
                        hintText: 'Write addtional text',
                        border: InputBorder.none),
                    maxLines: 8,
                  ),
                ),
              ),
              InkWell(
                  onTap: () => () {
                        if (file != null) {
                          uploadFile(uid, username, profilePic);
                        }
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => AddPost()));
                      },
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(12.0),
                      color: Color.fromARGB(255, 139, 64, 251),
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text("upload",
                            style: TextStyle(
                              fontFamily: "ananias",
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                            )),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future fileSelect() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
  }
}
