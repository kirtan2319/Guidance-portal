import 'package:flutter/material.dart';
import 'package:newapp/providers/providerUser.dart';
import 'package:newapp/utils/dimension.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout(
      {Key? key,
      required this.mobileScreenLayout,
      required this.webScreenLayout})
      : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataAdd();
  }

  dataAdd() async {
    providerUser _userProvider =
        Provider.of<providerUser>(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        // webscreen
        return widget.webScreenLayout;
      } else {
        return widget.mobileScreenLayout;
      }
      // mobile screen
    }));
  }
}
