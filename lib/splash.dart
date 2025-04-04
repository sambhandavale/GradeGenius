import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gradegenius/views/main/landing_page.dart';
import 'package:gradegenius/views/static/loading.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder:(context) => LandingPage())
        );
    });
  }

  @override
  Widget build(BuildContext context){
    return LoadingScreen();
  }
}