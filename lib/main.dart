import 'package:bank_flutter/homepage.dart';
import 'package:bank_flutter/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SchoolDis',
      darkTheme: ThemeData.dark().copyWith(textTheme: const TextTheme()),
      theme: ThemeData.dark(),
      //  home: FirebaseAuth.instance.currentUser == null
      //       ?  SignInPageNew()
      //       :  MySample(),
      home: HomePage(),
    );
  }
}
