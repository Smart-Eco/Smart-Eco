import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smarteco2/Devices/totalEnergy.dart';
import 'package:smarteco2/Screens/base_nav.dart';
import 'package:smarteco2/Screens/home_screen.dart';
import 'package:smarteco2/Screens/login_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smarteco2/Screens/splash_screens.dart';
import 'package:smarteco2/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggin = false;

  checkState() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          isLoggin = true;
        });
      } else {
        setState(() {
          isLoggin = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/baseNav': (context) => BaseNav(),
        '/signout': (context) => const LoginScreen(),
      },
      home: Scaffold(
        body: isLoggin ? BaseNav() : const splashScreen(),
      ),
    );
  }
}
