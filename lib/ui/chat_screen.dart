import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/responsive/mobilescreen_layout.dart';
import 'package:newapp/ui/chatRoom.dart';
import 'package:newapp/ui/contentpage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  String chatRoomId(String user1, String user2) {
    print("$user1$user2");

    if (user1.toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection("newusers")
        .where("email", isGreaterThanOrEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 139, 64, 251),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MobileScreenLayout()));
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.white,
                  )),
              Expanded(
                child: Text(
                  'Messages',
                  style: TextStyle(fontFamily: 'ananias'),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/backgroundimg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(15),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(185, 245, 244, 244)),
                    child: TextField(
                      controller: _search,
                      decoration: InputDecoration(
                          hintText: ("Search by email"),
                          hintStyle:
                              TextStyle(color: Color.fromARGB(154, 34, 33, 33)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )),
              ),
              ElevatedButton(
                  onPressed: onSearch,
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(
                        255, 139, 64, 251), // background (button) color
                    onPrimary: Colors.white, // foreground (text) color
                  ),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text("Search")),
              userMap != null
                  ? ListTile(
                      onTap: () {
                        String roomId = chatRoomId(
                            _auth.currentUser!.email!, userMap?['email']);
                        print(roomId);

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ChatRoom(
                              chatRoomId: roomId,
                              userMap: userMap!,
                            ),
                          ),
                        );
                      },
                      leading: Icon(Icons.account_box,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      title: Text(
                        userMap!["username"],
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        userMap!["email"],
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Icon(
                        Icons.chat,
                        color: Color.fromARGB(255, 253, 253, 253),
                      ),
                    )
                  : Container(),
            ],
          ),
        ));
  }
  // Widget chatTile(){
  //   return Container(
  //     child:Row(children: [],)
  //   )
  // }

}
