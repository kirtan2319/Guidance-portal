import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newapp/providers/providerUser.dart';
import 'package:newapp/responsive/mobilescreen_layout.dart';
import 'package:newapp/responsive/web_screen_layout.dart';
import 'package:newapp/ui/aspirant_guide_selection.dart';
import 'package:newapp/ui/chat_screen.dart';
import 'package:newapp/ui/loginpage.dart';
import 'package:newapp/ui/signuppage.dart';
import 'package:newapp/responsive/responsive_layout_screen.dart.dart';
import 'package:provider/provider.dart';

import 'ui/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyAZW7PP0FwByTEjd_6Js6r-e7w6llB1BcU",
      appId: "1:73300636207:web:37fd07af92c8cccf178cda",
      messagingSenderId: "73300636207",
      projectId: "devnewapp-b5982",
      storageBucket: "devnewapp-b5982.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (_) => providerUser(),
                    ),
                  ],
                  child: ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return loginscreen();
          })));
  // persisted user
}
