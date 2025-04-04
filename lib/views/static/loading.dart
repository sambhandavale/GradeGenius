import 'package:flutter/material.dart';
import 'package:gradegenius/utils/constants.dart';
import 'package:gradegenius/utils/orientation.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    setOrientation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      body: Center(
        child: Image.asset(Constants.loader),
      ),
    );
  }
}
