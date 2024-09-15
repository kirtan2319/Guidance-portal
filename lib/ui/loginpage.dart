import 'package:flutter/material.dart';
import 'package:newapp/resources/auth_methods.dart';
import 'package:newapp/responsive/mobilescreen_layout.dart';
import 'package:newapp/ui/aspirant_guide_selection.dart';
import 'package:newapp/ui/aspirant_signup_page.dart';
import 'package:newapp/ui/signuppage.dart';
import 'package:newapp/widgets/text_field_input.dart';
import 'package:newapp/utils/utils.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool hidepassword = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "success") {
      print(res);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MobileScreenLayout()));
    } else {
      res = 'failure';
      showSnackBAr(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void togglepassword() {
    if (hidepassword == true) {
      hidepassword = false;
    } else {
      hidepassword = true;
    }
    setState(() {});
  }

  void goToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const loginscreen()));
  }

  void goToSign() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const aspirantGuideSelection()));
  }

  @override
  Widget build(BuildContext context) {
    final fsize = MediaQuery.of(context).size.width;
    return Scaffold(
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
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.06),
        width: double.infinity,
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: 0.0, left: 20, right: 20, bottom: 20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                          image: AssetImage("assets/images/taglinelogo.png"),
                          fit: BoxFit.cover))),
              // SizedBox(
              //   height: 64,
              // ),
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
                        textInputType: TextInputType.emailAddress
                        ),
                        
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
              InkWell(
                onTap: loginUser,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.purple[400]),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "Log in",
                          style: TextStyle(
                              color: Color.fromARGB(255, 231, 230, 230),
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02),
                        ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      goToSign();
                    },
                    child: Container(
                      child: Text(
                        " SIGN UP",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
