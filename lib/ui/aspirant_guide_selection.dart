import 'package:flutter/material.dart';
import 'package:newapp/ui/aspirant_signup_page.dart';
import 'package:newapp/ui/guide_signup_page.dart';

import 'loginpage.dart';

class aspirantGuideSelection extends StatelessWidget {
  const aspirantGuideSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 139, 64, 251),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => loginscreen(),
                  ));
                },
                icon: Icon(Icons.arrow_back)),
            title: const Text(
              'Select',
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Are you',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.04,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: 0.0, left: 20, right: 20, bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: const DecorationImage(
                            image: AssetImage("assets/images/aspirant.png"),
                            fit: BoxFit.cover))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                InkWell(
                  onTap: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => aspirantSignup()));
                  }),
                  child: Container(
                    child: Text(
                      "Aspirant",
                      style: TextStyle(
                          color: Color.fromARGB(255, 246, 233, 233),
                          fontWeight: FontWeight.bold),
                    ),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.3,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.purple[400]),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  'Or',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: 0.0, left: 20, right: 20, bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: const DecorationImage(
                            image: AssetImage("assets/images/guide.png"),
                            fit: BoxFit.cover))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                InkWell(
                  onTap: (() {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => guideSignup()));
                  }),
                  child: Container(
                    child: Text(
                      "Guide",
                      style: TextStyle(
                          color: Color.fromARGB(255, 246, 233, 233),
                          fontWeight: FontWeight.bold),
                    ),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.3,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.purple[400]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
