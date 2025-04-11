import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradegenius/components/kaksha/post_card.dart';
import 'package:gradegenius/components/shared/app_bar.dart';
import 'package:gradegenius/components/shared/kaksha_app_bar.dart';
import 'package:gradegenius/utils/constants.dart';
import 'package:gradegenius/views/main/add_assignment.dart';
import 'package:gradegenius/views/main/assignment.dart';

final List<Map<String, String>> fileList = [
  // {
  //   "filename": "Assignment 0",
  //   "datetime": "Mar 25, 15:31",
  // },
  // {
  //   "filename": "Tuesday Lecture Notes",
  //   "datetime": "Mar 26, 10:00",
  // },
  // {
  //   "filename": "Project Guidelines",
  //   "datetime": "Mar 27, 14:45",
  // },
  // {
  //   "filename": "Syllabus",
  //   "datetime": "Mar 28, 09:30",
  // },
];


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
    appBar: KakshaAppBar(
      kakshaName: "Data Structure",
      kakshaMembers: "32 Members",
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddAssignment()),
                  );
                },
                child: Expanded(
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
          if(selectedIndex == 1)
          _buildFiles(),
          if(selectedIndex == 2)
          _buildDoubts()
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
              name: 'Shweta',
              dateTime: 'Mar 25, 15:31',
              buttonText: 'View',
              profilePic: '',
              title: 'Assignment 0',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AboutAssignment(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            PostCard(
              name: 'Shweta',
              dateTime: 'Mar 25, 15:31',
              buttonText: 'View',
              profilePic: '',
              title: 'Assignment 1',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AboutAssignment(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            PostCard(
              name: 'Shweta',
              dateTime: 'Mar 25, 15:31',
              buttonText: 'View',
              profilePic: '',
              title: 'Assignment 3',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AboutAssignment(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiles() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: fileList.map((file) {
            return _buildFileCard(
              filename: file['filename']!,
              datetime: file['datetime']!,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFileCard({required String filename, required String datetime}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                filename,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                datetime,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Colors.white10,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.download,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _buildDoubts(){
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            PostCard(
              name: 'Maitri',
              dateTime: 'Mar 25, 15:31',
              buttonText: 'Solve',
              profilePic: '',
              title: 'Why is the worst-case time complexity of Quicksort O(n²) but its average-case O(n log n)?`',
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            PostCard(
              name: 'Ojasvi',
              dateTime: 'Mar 25, 15:31',
              buttonText: 'Solve',
              profilePic: '',
              title: 'Why is binary search not applicable to an unsorted array?',
              onPressed: () {},
            ),
          ],
        ),
      ),
    ); 
  }
}


