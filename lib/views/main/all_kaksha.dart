import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradegenius/components/landing/feature_box.dart';
import 'package:gradegenius/components/shared/app_bar.dart';
import 'package:gradegenius/components/shared/bottom_nav.dart';
import 'package:gradegenius/utils/constants.dart';
import 'package:gradegenius/views/main/kaksha.dart';

class KakshaModel {
  final String name;
  final int memberCount;

  KakshaModel({
    required this.name,
    required this.memberCount,
  });
}

final List<KakshaModel> kakshaList = [
  KakshaModel(name: 'Data Structure', memberCount: 2),
];


class AllKaksha extends StatefulWidget {
  @override
  _AllKakshaState createState() => _AllKakshaState();
}

class _AllKakshaState extends State<AllKaksha> { 
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
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
        child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Kakshas",
                style: TextStyle(
                  color: Constants.darkThemeFontColor,
                  fontSize: 35,
                  fontFamily: 'GoogleSans',
                  height: 1,
                ),
              ),
              const SizedBox(height: 30),
              ...kakshaList.map((kaksha) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CreateCardFeature(
                  imagePath: 'assets/images/kaksha.png',
                  topText: kaksha.name,
                  bottomText: '${kaksha.memberCount} Members',
                  buttonText: 'View',
                  height: 200,
                  imageTop: -50,
                  imageLeft: 100,
                  imageHeight: 400,
                  imageWidth: 400,
                  wantImg: false,
                  btFontSize: 18,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Kaksha(),
                      ),
                    );
                  }
                ),
              )),
            ],
          )
          
      ),
    ),
  );
  
  }
}

