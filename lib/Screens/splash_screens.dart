import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smarteco2/Screens/route.dart';
import 'package:google_fonts/google_fonts.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  bool expand = false;
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      setState(() {
        expand = true;
      });
    });

    Timer(Duration(seconds: 4), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => loginScreen()));
    });

    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final splashHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 600),
                height: expand ? splashHeight * 0.5 : 0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/splash1.png"),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                top: 290,
                left: 0,
                right: 0,
                child: Image.asset(
                  "assets/logo.png",
                  width: 70,
                  height: 70,
                ),
              )
            ],
          ),
          expand
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'SmartEco',
                    style: GoogleFonts.rubik(
                      color: Color(0xFF0F0F0F),
                      fontSize: 48,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                )
              : SizedBox(height: 300),
          expand
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'A new way to control your home ',
                    style: GoogleFonts.rubik(
                      color: Color(0xFF0F0F0F),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                )
              : SizedBox(height: 300),
        ],
      ),
    );
  }
}
