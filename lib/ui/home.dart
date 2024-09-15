
import 'package:flutter/material.dart';

class Portal extends StatefulWidget {
  const Portal({Key? key}) : super(key: key);

  @override
  State<Portal> createState() => _PortalState();
}

class _PortalState extends State<Portal> {
  bool hidepassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/backgroundimg.jpg",
                ),
                opacity: 200.0,
                fit: BoxFit.cover),
          ),
          // margin:
          //     EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          alignment: Alignment.center,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(5.0),
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(
                      top: 0.0, left: 20, right: 20, bottom: 20),
                  width: 250,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                          image: AssetImage("assets/images/taglinelogo.png"),
                          fit: BoxFit.cover))),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: 50.0,
                      child: TextFormField(
                        cursorColor: Colors.black,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w200,
                            letterSpacing: 2.0),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            size: 40,
                            color: Color.fromARGB(255, 158, 157, 157),
                          ),
                          hintText: "Enter Email",
                          filled: true,
                          fillColor: Color.fromARGB(255, 203, 203, 203),
                          // labelText: "LabelText",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          // suffixIcon: Icon(
                          //   Icons.mail,
                          //   color: Colors.grey.shade700,
                          // )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: 50,
                      child: TextFormField(
                        obscureText: hidepassword,
                        cursorColor: Colors.black,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            letterSpacing: 2.0),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            size: 40,
                            color: Color.fromARGB(255, 158, 157, 157),
                          ),
                          suffixIcon: InkWell(
                            onTap: togglepassword,
                            child: Icon(
                              Icons.visibility,
                              color: Color.fromARGB(255, 109, 108, 108),
                            ),
                          ),
                          hintText: "Enter Your Password",
                          filled: true,
                          fillColor: Color.fromARGB(255, 203, 203, 203),
                          // labelText: "LabelText",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          // suffixIcon: Icon(
                          //   Icons.visibility_off,
                          //   color: Colors.grey.shade700,
                          // )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: 35,
                      width: 100.0,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "LOG IN",
                            style: TextStyle(
                                fontFamily: "ananias", fontSize: 15.0),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purpleAccent),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0))),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Column(children: [
                        const Text("NOT A MEMBER?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                fontFamily: "ananias")),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FlatButton(
                            color: Color.fromARGB(0, 0, 0, 0),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => signup()));
                            },
                            child: const Text(
                              "sign up",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontFamily: "ananias"),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      width: 350,
                      height: 70,
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.purple.shade400,
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Text(
                                "HELPING YOU ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "ananias"),
                              ),
                              Text(
                                "ACHIEVE YOUR DREAMS",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "ananias"),
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  void togglepassword() {
    if (hidepassword == true) {
      hidepassword = false;
    } else {
      hidepassword = true;
    }
    setState(() {});
  }
}

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  bool hidepassword = true;
  dynamic _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/backgroundimg.jpg",
                ),
                opacity: 200.0,
                fit: BoxFit.cover)),
        alignment: Alignment.center,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(5.0),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: 0.0, left: 20.0, right: 20.0, bottom: 20.0),
              width: 250,
              height: 200,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("assets/images/taglinelogo.png"),
                      fit: BoxFit.cover)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "CREATE YOUR ACCOUNT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 136, 68, 216),
                    fontFamily: "ananias",
                    fontSize: 22,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 17.0, bottom: 10.0, left: 10.0, right: 10.0),
                  child: SizedBox(
                    height: 50.0,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          letterSpacing: 2.0),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          size: 40,
                          color: Color.fromARGB(255, 158, 157, 157),
                        ),
                        hintText: "Enter Your Name",
                        filled: true,
                        fillColor: Color.fromARGB(255, 203, 203, 203),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 50.0,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          letterSpacing: 2.0),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          size: 40,
                          color: Color.fromARGB(255, 158, 157, 157),
                        ),
                        hintText: "Enter Your Email",
                        filled: true,
                        fillColor: Color.fromARGB(255, 203, 203, 203),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 50.0,
                    child: TextFormField(
                      obscureText: hidepassword,
                      cursorColor: Colors.black,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          letterSpacing: 2.0),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          size: 40,
                          color: Color.fromARGB(255, 158, 157, 157),
                        ),
                        suffixIcon: InkWell(
                          onTap: togglepassword,
                          child: Icon(
                            Icons.visibility,
                            color: Color.fromARGB(255, 109, 108, 108),
                          ),
                        ),
                        hintText: "Enter Your Password",
                        filled: true,
                        fillColor: Color.fromARGB(255, 203, 203, 203),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "You are :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 136, 68, 216),
                      fontFamily: "ananias",
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 450,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color.fromARGB(255, 203, 203, 203),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 50),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            Radio(
                                value: 1,
                                groupValue: _value,
                                onChanged: (val) {
                                  _value = val;
                                  setState(() {});
                                }),
                            Text(
                              "Aspirant",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 65, 65, 65),
                                letterSpacing: 2.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(left: 50),
                        child: Row(
                          children: <Widget>[
                            Radio(
                                value: 2,
                                groupValue: _value,
                                onChanged: (val) {
                                  _value = val;
                                  setState(() {});
                                }),
                            Text(
                              "Guide",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 65, 65, 65),
                                  letterSpacing: 2.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SizedBox(
                    height: 45,
                    width: 150.0,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "sign up",
                          style:
                              TextStyle(fontFamily: "ananias", fontSize: 18.0),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purpleAccent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0))),
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void togglepassword() {
    if (hidepassword == true) {
      hidepassword = false;
    } else {
      hidepassword = true;
    }
    setState(() {});
  }
}
