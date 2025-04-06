import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradegenius/components/kaksha/post_card.dart';
import 'package:gradegenius/components/landing/feature_box.dart';
import 'package:gradegenius/components/shared/app_bar.dart';
import 'package:gradegenius/utils/constants.dart';

class Kaksha extends StatefulWidget {

  @override
  _KakshaState createState() => _KakshaState();
}

class _KakshaState extends State<Kaksha> { 
  bool isAuth = true;
  int selectedIndex = 0;

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
    body: buildKakshaControls()
  );
  
  }

  Widget buildKakshaControls() {
    return Padding(
      padding: const EdgeInsets.only(top:120,bottom: 0, left: 40,right:40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSlideOption(0,'Posts', 'assets/icons/kaksha/posts.svg'),
                SizedBox(width: 10),
                _buildSlideOption(1,'Files', 'assets/icons/kaksha/files.svg'),
                SizedBox(width: 10),
                _buildSlideOption(2,'Doubts', 'assets/icons/kaksha/files.svg'),
                SizedBox(width: 10),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Assignment",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: 'GoogleSans',
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/icons/kaksha/files.svg',
                        width: 28,
                        height: 28,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.auto_awesome, color: Colors.blueAccent, size: 20),
              ),
            ],
          ),
          SizedBox(height: 16),
          if(selectedIndex == 0)
          _buildPosts(),
        ],
      ),
    );
  }
 
  Widget _buildSlideOption(int index, String text, String logo) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color.fromARGB(255, 255, 184, 60) : Colors.grey[800],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontFamily: 'GoogleSans',
                fontSize: 22,
              ),
            ),
            SizedBox(width: 10),
            SvgPicture.asset(
              logo,
              width: 28,
              height: 28,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPosts() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            PostCard(
              name: 'Samarth',
              dateTime: 'Mar 25, 15:31',
              buttonText: 'View',
              profilePic: '',
              title: 'Assignment 0',
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            PostCard(
              name: 'Samarth',
              dateTime: 'Mar 25, 15:31',
              buttonText: 'View',
              profilePic: '',
              title: 'Assignment 1',
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            PostCard(
              name: 'Samarth',
              dateTime: 'Mar 25, 15:31',
              buttonText: 'View',
              profilePic: '',
              title: 'Assignment 3',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

}


