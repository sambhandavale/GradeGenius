import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gradegenius/providers/authProvider.dart';
import 'package:gradegenius/views/auth/home.dart';
import 'package:gradegenius/views/main/main_page.dart';
import 'package:gradegenius/views/static/loading.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key}); 

  @override 
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  @override
  void initState() {
    super.initState();
    _initialize();
  }

    Future<void> _initialize() async {
    await _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.checkLoginStatus();
    await authProvider.fetchUser();

    if (!mounted) return;

    _handleNavigation(authProvider);
  }

  Future<void> _handleNavigation(AuthProvider authProvider) async {
    if (!mounted) return;

    if (authProvider.isAuthenticated) {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (context) => const HomeController()));
    } else {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context){
    return LoadingScreen();
  }
}