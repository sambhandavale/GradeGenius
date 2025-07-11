import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradegenius/components/landing/feature_box.dart';
import 'package:gradegenius/components/landing/pop_up.dart';
import 'package:gradegenius/components/shared/app_bar.dart';
import 'package:gradegenius/utils/constants.dart';
import 'package:gradegenius/views/main/add_assignment.dart';
import 'package:gradegenius/views/main/create_kaksha.dart';
import 'package:gradegenius/views/main/presentation.dart';
import 'package:gradegenius/views/main/student/join_kaksha.dart';

class LandingPage extends StatefulWidget {
  final bool popup;
  final VoidCallback? goToAllKaksha;
  final VoidCallback? goToPPT;
  final String role;

  const LandingPage({super.key, required this.popup, this.goToAllKaksha, this.goToPPT, required this.role});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> { 

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.popup) {
        showInfoPopup(context);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    extendBodyBehindAppBar: true,
    backgroundColor: Constants.darkThemeBg,
    appBar: CustomGreetingAppBar(
      avatarImage: AssetImage('assets/images/avatar.png'),
      addLogout: true,
      hidBack:true,
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Let’s Learn Smarter, Not Harder!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontFamily: 'GoogleSans',
                height: 1,
              ),
            ),
            const SizedBox(height: 30),
            CreateCardFeature(
              imagePath: 'assets/images/kaksha.png',
              topText: widget.role == 'student' ? 'Join':'Create',
              bottomText: 'Kaksha',
              buttonText: widget.role == 'student' ? 'Join':'Create',
              height: 250,
              imageTop: -50,
              imageLeft: 100,
              imageHeight: 400,
              imageWidth: 400,
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => widget.role == 'teacher' ? CreateKaksha() : JoinKaksha()),
                );

                if (result == 'goToAllKaksha') {
                  widget.goToAllKaksha?.call();
                }
              }
            ),


            const SizedBox(height: 20),
            if(widget.role == 'teacher')
            CreateCardFeature(
              imagePath: 'assets/images/ppt.png',
              topText: 'Generate',
              bottomText: 'PPT',
              buttonText: 'Generate',
              height: 250,
              imageTop: 0,
              imageLeft: 100,
              imageHeight: 300,
              imageWidth: 300,
              bgColor: const Color.fromARGB(255, 108, 177, 113),
              onPressed: () {
                // widget.goToPPT.call();
                widget.goToPPT?.call();
              },
            ),
            const SizedBox(height: 20),
            if(widget.role == 'teacher')
            CreateCardFeature(
              imagePath: 'assets/images/ppt.png',
              topText: 'Generate',
              bottomText: 'Notes',
              buttonText: 'Generate',
              height: 250,
              imageTop: 0,
              imageLeft: 100,
              imageHeight: 300,
              imageWidth: 300,
              bgColor: const Color.fromARGB(255, 130, 153, 255),
              onPressed: () {
                widget.goToPPT?.call();
              }
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
  
  }
}

void showInfoPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => InfoPopup(),
  );
}

