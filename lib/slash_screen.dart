import 'dart:async';

import 'package:ai_assistance/home_page.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => homepage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff60E27),
      body: Container(
        color: Color(0xff070F28),
        child: Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SlideInUp(
                    child: Container(
                      width: 300,
                      height: 300,
                      child: Image.asset(
                        'assets/images/Designer.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ))),
      ),
    );
  }
}
