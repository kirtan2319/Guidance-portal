import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newapp/providers/providerUser.dart';
import 'package:newapp/utils/globalvar.dart';
import 'package:newapp/manage/forAspirant.dart' as manage1;
import 'package:newapp/manage/forGuide.dart' as manage2;
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String name = "";
  String person = '';
  int type = 0;
  int _page = 0;
  late PageController pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdetails();
    pageController = PageController();
  }

  // Future<DocumentSnapshot> getName() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('aspirant')
  //       .doc('aspirant')
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   if (snap.data() == null) {
  //     DocumentSnapshot snap = await FirebaseFirestore.instance
  //         .collection('guide')
  //         .doc('guide')
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get();
  //     print(snap.data());
  //     print("guide");
  //     return snap;
  //   } else {
  //     print("aspirant");
  //     print(snap.data());
  //     return snap;
  //   }
  //   setState(() {
  //     name = (snap.data() as Map<String, dynamic>)["username"];
  //   });
  //   print("$name");
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void getdetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('newusers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      person = (snap.data() as Map<String, dynamic>)["person"];
    });
  }
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) =>  AlertDialog(
            title: Text("Do you want to exit the app?", style: TextStyle(fontFamily: "Ananias", fontSize: 16.0),),
            alignment: Alignment.center,
            actions: [
              ElevatedButton(
                onPressed: ()=>Navigator.pop(context, false), child: const Text("No", style: TextStyle(fontFamily: "Ananias", fontSize: 14),),style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Theme.of(context).colorScheme.primary.withOpacity(0.5);
        return null; // Use the component's default.
      },
    ),
  ),
                ),
              ElevatedButton(child: Text("Yes",style: TextStyle(fontFamily: "Ananias", fontSize: 14),), onPressed: ()=>Navigator.pop(context, true),style:ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Theme.of(context).colorScheme.primary.withOpacity(0.5);
        return null; // Use the component's default.
      },
    ),
  ), )
            ],
          )
          );

  @override
  Widget build(BuildContext context) {
    if (person == 'Guide') {
      return WillPopScope(
        onWillPop: () async {
        print("quit button pressed");
        final shouldpop = await showWarning(context);

        return shouldpop??false;},
        child: Material(
          child: Scaffold(
            body: PageView(
              children: homeScreenItems1,
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: onPageChanged,
            ),
            bottomNavigationBar: CupertinoTabBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home,
                        color: _page == 0
                            ? Colors.white
                            : Color.fromARGB(255, 197, 194, 194),
                        size: 30.0),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search_rounded,
                        color: _page == 1
                            ? Colors.white
                            : Color.fromARGB(255, 197, 194, 194),
                        size: 30.0),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle_outline,
                        color: _page == 2
                            ? Colors.white
                            : Color.fromARGB(255, 197, 194, 194),
                        size: 30.0),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person,
                        color: _page == 3
                            ? Colors.white
                            : Color.fromARGB(255, 197, 194, 194),
                        size: 30.0),
                    label: ''),
              ],
              backgroundColor: Color.fromARGB(255, 139, 64, 251),
              onTap: navigationTapped,
            ),
          ),
        ),
      );
    } else {
      return Material(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: PageView(
            children: homeScreenItems2,
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: onPageChanged,
          ),
          bottomNavigationBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home,
                      color: _page == 0
                          ? Colors.white
                          : Color.fromARGB(255, 197, 194, 194),
                      size: 30.0),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search_rounded,
                      color: _page == 1
                          ? Colors.white
                          : Color.fromARGB(255, 197, 194, 194),
                      size: 30.0),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline,
                      color: _page == 2
                          ? Colors.white
                          : Color.fromARGB(255, 197, 194, 194),
                      size: 30.0),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person,
                      color: _page == 3
                          ? Colors.white
                          : Color.fromARGB(255, 197, 194, 194),
                      size: 30.0),
                  label: ''),
            ],
            backgroundColor: Color.fromARGB(255, 139, 64, 251),
            onTap: navigationTapped,
          ),
        ),
      );
    }
  }
}
