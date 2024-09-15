import 'package:flutter/material.dart';
import 'package:newapp/resources/auth_methods.dart';

import '../widgets/text_field_input.dart';

class signupscreen extends StatefulWidget {
  const signupscreen({Key? key}) : super(key: key);

  @override
  State<signupscreen> createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 64,
            ),
            //
            Stack(
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage("https://picsum.photos/"),
                ),
                Positioned(
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.add_a_photo)))
              ],
            ),
            TextFieldInput(
                hintText: 'Enter Your Username',
                isPass: false,
                textEditingController: _usernameController,
                textInputType: TextInputType.text),
            SizedBox(
              height: 24,
            ),
            TextFieldInput(
                hintText: 'Enter Your Email',
                isPass: false,
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress),
            SizedBox(
              height: 24,
            ),
            TextFieldInput(
                hintText: 'Enter Your Password',
                isPass: true,
                textEditingController: _passwordController,
                textInputType: TextInputType.text),
            SizedBox(
              height: 24,
            ),
            TextFieldInput(
                hintText: 'Enter Your bio',
                isPass: false,
                textEditingController: _bioController,
                textInputType: TextInputType.text),
            SizedBox(
              height: 24,
            ),
            // InkWell(
            //   onTap: () async {
            //     String res = await AuthMethods().signUpAspirant(
            //         email: _emailController.text,
            //         password: _passwordController.text,
            //         username: _usernameController.text,
            //         bio: _bioController.text ,
            //         // file:
            //         );
            //     print(res);
            //   },
            //   child: Container(
            //     child: Text("Sign up"),
            //     height: 40,
            //     width: double.infinity,
            //     alignment: Alignment.center,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(15),
            //         color: Colors.blue),
            //   ),
            // ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      )),
    );
  }
}
