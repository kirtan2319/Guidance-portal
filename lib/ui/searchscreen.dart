import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newapp/ui/searchguideprofile.dart';

class searchScreen extends StatefulWidget {
  searchScreen({Key? key}) : super(key: key);

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  final TextEditingController searchCtrl = TextEditingController();
  bool showUsers = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 179, 64, 251),
          title: Container(
            height: MediaQuery.of(context).size.height * 0.08,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            margin: EdgeInsets.all(5),
            child: TextFormField(
              controller: searchCtrl,
              decoration: const InputDecoration(
                  labelText: '  Search users',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 114, 114, 114))),
              onFieldSubmitted: (String _) {
                setState(() {
                  showUsers = true;
                });
              },
            ),
          ),
        ),
        body: showUsers
            ? Container(
                constraints: BoxConstraints.expand(),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/backgroundimg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('newusers')
                        .where('username',
                            isGreaterThanOrEqualTo: searchCtrl.text)
                        .get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        itemBuilder: ((context, index) {
                          if ((snapshot.data! as dynamic).docs[index]
                                  ['person'] ==
                              'Guide') {
                            return InkWell(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => searchGuideProfile(
                                          uid: (snapshot.data! as dynamic)
                                              .docs[index]['uid']))),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    (snapshot.data! as dynamic).docs[index]
                                        ['profilePic'],
                                  ),
                                ),
                                title: Column(
                                  children: [
                                    Text(
                                      (snapshot.data! as dynamic).docs[index]
                                          ['username'],
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.028,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                    Text(
                                        (snapshot.data! as dynamic)
                                            .docs[index]['college'],
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                            color: Color.fromARGB(
                                                255, 115, 115, 115)))
                                  ],
                                ),
                                trailing: Text(
                                    '~ ${(snapshot.data! as dynamic).docs[index]['person']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.022,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.greenAccent)),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                      );
                    }),
              )
            : Center(
                child: Container(
                    constraints: BoxConstraints.expand(),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/backgroundimg.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.32,
                    width: MediaQuery.of(context).size.width * 0.36,
                    child: Icon(Icons.search_outlined,
                        color: Colors.greenAccent, size: 80)),
              ));
  }
}
