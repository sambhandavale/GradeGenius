import 'package:flutter/material.dart';
import 'package:gradegenius/splash.dart';
// import 'package:gradegenius/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GradeGenius',
      debugShowCheckedModeBanner: false,
      home:SplashScreen()
    );
  }
}

