import 'package:flutter/material.dart';
import 'package:newapp/ui/aspirantpostscreen.dart';
import 'package:newapp/ui/aspirantprofilescreen.dart';
import 'package:newapp/ui/contentpage.dart';
import 'package:newapp/ui/guideprofilescreen.dart';
import 'package:newapp/ui/postscreen.dart';
import 'package:newapp/ui/searchscreen.dart';

var homeScreenItems1 = [
  contentPage(),
  searchScreen(),
  AddPost(),
  guideProfileScreen(),
];
var homeScreenItems2 = [
  contentPage(),
  searchScreen(),
  aspirantPostScreen(),
  aspirantProfileScreen(),
];
