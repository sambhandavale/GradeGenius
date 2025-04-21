import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradegenius/api/routes/get/kaksha/list_kaksha.dart';
import 'package:gradegenius/components/kaksha/kaksha_box.dart';
import 'package:gradegenius/components/landing/feature_box.dart';
import 'package:gradegenius/components/shared/app_bar.dart';
import 'package:gradegenius/models/allkaksha.dart';
import 'package:gradegenius/utils/constants.dart';
import 'package:gradegenius/views/main/kaksha.dart';


class AllKaksha extends StatefulWidget {
  final String role;

  const AllKaksha({super.key, required this.role});

  @override
  _AllKakshaState createState() => _AllKakshaState();
}

class _AllKakshaState extends State<AllKaksha> { 
  bool isAuth = true;
  List<KakshaList> kakshaList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getAllKaksha();
  }

  Future<void> getAllKaksha() async {
    try {
      final kakshas = await allKaksha();
      List<KakshaList> tempKakshaList = [];
      
      if (kakshas['statusCode'] == 200) {
        for (var kakshaData in kakshas['data']['kakshas']) {
          tempKakshaList.add(KakshaList.fromJson(kakshaData));
        }

        setState(() {
          kakshaList = tempKakshaList;
          isLoading = false;
        });
      } else {
        setState(() {
          kakshaList = [];
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error in getAllKaksha: $e');
      setState(() {
        kakshaList = [];
        isLoading = false;
      });
    }
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
        padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 60),
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
              if(!isLoading)
              ...kakshaList.map((kaksha) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: KakshaBox(
                  topText: kaksha.name,
                  bottomText: '${kaksha.members.length} Members',
                  buttonText: 'View',
                  height: 200,
                  btFontSize: 18,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Kaksha(kakshaId: kaksha.id,members: kaksha.members.length,kakshaName: kaksha.name,),
                      ),
                    );
                  },
                  kakshaId: kaksha.id,
                  kakshaCode: kaksha.inviteCode,
                  getAllKaksha:getAllKaksha,
                  role:widget.role
                ),
              )),
              if(!isLoading && kakshaList.isEmpty)
              Text(
                "You don't have any Kakshas",
                style: TextStyle(
                  color: Constants.darkThemeFontColor,
                  fontSize: 35,
                  fontFamily: 'GoogleSans',
                  height: 1,
                ),
              ),
              const SizedBox(height: 30),
            ],
          )
          
      ),
    ),
  );
  
  }
}

