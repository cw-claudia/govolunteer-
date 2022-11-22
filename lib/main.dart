import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_volunter/view/NPO/NGOMap.dart';
import 'package:go_volunter/view/auth/Login.dart';
import 'package:go_volunter/view/auth/main_page.dart';


import 'firebase_options.dart';

Future<void>  main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'I Volunteer',

        home: MainPage()
    );
  }
}

