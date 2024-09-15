import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:newapp/responsive/mobilescreen_layout.dart';
import 'package:newapp/responsive/responsive_layout_screen.dart.dart';
import 'package:newapp/responsive/web_screen_layout.dart';

import '../resources/auth_methods.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';

import 'aspirant_guide_selection.dart';

class guideSignup extends StatefulWidget {
  const guideSignup({Key? key}) : super(key: key);

  @override
  State<guideSignup> createState() => _guideSignupState();
}

class _guideSignupState extends State<guideSignup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  Uint8List? _image;
  String person = "Guide";
  bool _isLoading = false;
  bool hidepassword = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    _collegeController.dispose();
  }

  void selectPic() async {
    Uint8List im = await pickPhoto(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpGuide() async {
    setState(() {
      _isLoading = true;
    });
    String res = await secondAuthMethods().signUpGuide(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        college: _collegeController.text,
        bio: _bioController.text,
        file: _image!,
        person: person);
    print(res);
    setState(() {
      _isLoading = false;
    });
    if (res != "success") {
      showSnackBAr(res, context);
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MobileScreenLayout(),
        // ResponsiveLayout
        //       mobileScreenLayout: MobileScreenLayout(),
        //       webScreenLayout: WebScreenLayout(),
      ));
    }
  }

  void togglepassword() {
    if (hidepassword == true) {
      hidepassword = false;
    } else {
      hidepassword = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 139, 64, 251),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => aspirantGuideSelection(),
              ));
            },
            icon: Icon(Icons.arrow_back)),
        title: const Text(
          'Sign up',
          style: TextStyle(fontFamily: 'ananias'),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
          child: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/backgroundimg.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Stack(children: [
                  _image != null
                      ? CircleAvatar(
                          radius: MediaQuery.of(context).size.height * 0.09,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: MediaQuery.of(context).size.height * 0.09,
                          backgroundImage: NetworkImage(
                              "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg"),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectPic,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ]),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: TextFieldInput(
                    hintText: 'Enter Your Username',
                    isPass: false,
                    textEditingController: _usernameController,
                    textInputType: TextInputType.text),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: TextFieldInput(
                    hintText: 'Enter Your Email',
                    isPass: false,
                    textEditingController: _emailController,
                    textInputType: TextInputType.emailAddress),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    TextFieldInput(
                        hintText: 'Enter Your Password',
                        isPass: hidepassword,
                        textEditingController: _passwordController,
                        textInputType: TextInputType.text),
                    InkWell(
                      onTap: togglepassword,
                      child: Icon(
                        Icons.visibility,
                        color: hidepassword
                            ? Color.fromARGB(255, 109, 108, 108)
                            : Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: TextFieldInput(
                    hintText: 'Enter Name Of Your College',
                    isPass: false,
                    textEditingController: _collegeController,
                    textInputType: TextInputType.text),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: TextFieldInput(
                    hintText: 'Enter Your bio',
                    isPass: false,
                    textEditingController: _bioController,
                    textInputType: TextInputType.text),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: signUpGuide,
                child: Container(
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                        color: Color.fromARGB(255, 231, 230, 230),
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.02),
                  ),
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.purple[400],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
