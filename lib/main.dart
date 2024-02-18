import 'package:ai_assistance/slash_screen.dart';
import 'package:ai_assistance/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:ai_assistance/pallete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Omkar',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: Pallete.whiteColor,
          appBarTheme: AppBarTheme(backgroundColor: Pallete.whiteColor)),
      home: splashScreen(),
    );
  }
}
