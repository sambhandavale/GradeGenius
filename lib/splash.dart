import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gradegenius/providers/authProvider.dart';
import 'package:gradegenius/views/auth/home.dart';
import 'package:gradegenius/views/main/landing_page.dart';
import 'package:gradegenius/views/main/main_page.dart';
import 'package:gradegenius/views/static/loading.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  bool isAuth = true;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    isAuth = authProvider.isAuthenticated;
    Timer(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (context) => isAuth ? HomeController() : HomePage()),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context){
    return LoadingScreen();
  }
}