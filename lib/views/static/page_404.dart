import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradegenius/components/shared/app_bar.dart';
import 'package:gradegenius/utils/constants.dart';

class Page404 extends StatefulWidget {

  @override
  _Page404State createState() => _Page404State();
}

class _Page404State extends State<Page404> { 
  bool isAuth = true;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    extendBodyBehindAppBar: true,
    backgroundColor: Constants.darkThemeBg,
    appBar: CustomGreetingAppBar(
      userName: "User",
      userRole: "Teacher",
      avatarImage: AssetImage('assets/images/avatar.png'),
    ),
    body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text(
          '404',
          style: TextStyle(
            fontFamily: 'GoogleSans',
            fontSize: 48,
            color: Constants.darkThemeFontColor,
            height: 1
          ),
        ),
        Text(
          'Sorry Page not found!',
          style: TextStyle(
            fontFamily: 'GoogleSans',
            fontSize: 20,
            color: Constants.darkThemeFontColor,
            height: 1
          ),
        ),
      ],
    ),
  ),

  );
  
  }
}


