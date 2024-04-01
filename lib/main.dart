import 'package:flutter/material.dart';
import 'package:smarteco2/Screens/base_nav.dart';
import 'package:smarteco2/Screens/home_screen.dart';
import 'package:smarteco2/Screens/login_Screen.dart';
import 'package:smarteco2/Screens/sign_up.dart';
import 'package:smarteco2/Screens/splash_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: loginScreen(),
      ),
    );
  }
}
