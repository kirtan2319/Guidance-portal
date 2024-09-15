import 'package:flutter/material.dart';
import 'package:newapp/ui/contentpage.dart';
import 'package:newapp/widgets/listofstudymaterial.dart';

class StudyMaterial extends StatefulWidget {
  const StudyMaterial({Key? key}) : super(key: key);

  @override
  State<StudyMaterial> createState() => _StudyMaterialState();
}

class _StudyMaterialState extends State<StudyMaterial> {
  // var current_type = 'Books';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 139, 64, 251),
        leading: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => contentPage(),
                  ));
                },
                icon: Icon(Icons.arrow_back)),
        title: Text(
          'Study Material',
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'Get the Study Material here',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.height * 0.030,
                      fontFamily: 'ananias'),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.12,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(12),
                  color: Color.fromARGB(255, 161, 75, 210),
                ),
                width: double.infinity,
                margin: EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            listOfStudyMaterial(type: 'booksposts')));
                  },
                  child: Text(
                    'Books',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.032),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.12,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(12),
                  color: Color.fromARGB(255, 161, 75, 210),
                ),
                width: double.infinity,
                margin: EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            listOfStudyMaterial(type: 'formulabookposts')));
                  },
                  child: Text(
                    'Formulabooks',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.032),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.12,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(12),
                  color: Color.fromARGB(255, 161, 75, 210),
                ),
                width: double.infinity,
                margin: EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            listOfStudyMaterial(type: 'otherposts')));
                  },
                  child: Text(
                    'Handnotes',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.032),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
