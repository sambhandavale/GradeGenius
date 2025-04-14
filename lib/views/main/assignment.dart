import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradegenius/components/landing/feature_box.dart';
import 'package:gradegenius/components/shared/kaksha_app_bar.dart';
import 'package:gradegenius/utils/constants.dart';

final List<Map<String, String>> fileList = [
  {
    "name": "Name 1",
    "rollno": "22102B0001",
  },
  {
    "name": "Name 2",
    "rollno": "22102B0002",
  },
  {
    "name": "Name 3",
    "rollno": "22102B0003",
  },
  {
    "name": "Name 4",
    "rollno": "22102B0004",
  },
  {
    "name": "Name 5",
    "rollno": "22102B0005",
  },
];


class AboutAssignment extends StatefulWidget {

  @override
  _AboutAssignmentState createState() => _AboutAssignmentState();
}

class _AboutAssignmentState extends State<AboutAssignment> { 
  bool isAuth = true;
  int selectedIndex = 0;
  bool openStudentAssignment = false;

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
    body: buildAssignmentControls()
  );
  
  }

  Widget buildAssignmentControls() {
    return Padding(
      padding: const EdgeInsets.only(top:120,bottom: 0, left: 40,right:40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSlideOption(0,'About'),
                SizedBox(width: 10),
                _buildSlideOption(1,'Submissions'),
                SizedBox(width: 10),
              ],
            ),
          ),
          SizedBox(height: 16),
          if(openStudentAssignment)
          _buildStudentAssignment(),
          if(selectedIndex == 0 && !openStudentAssignment)
          _buildAboutAssignment(),
          if(selectedIndex == 1 && !openStudentAssignment)
          _buildSubmissions(),
        ],
      ),
    );
  }
 
  Widget _buildSlideOption(int index, String text) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          openStudentAssignment = false;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
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
          ],
        ),
      ),
    );
  }

  Widget _buildAboutAssignment() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24,),
            const Text(
              'Assignment 1',
              style: TextStyle(
                fontSize: 38,
                fontFamily: 'GoogleSans',
                fontWeight: FontWeight.w500,
                color: Colors.white,
                height: 1
              ),
            ),
        
            // Due Date
            const SizedBox(height: 5),
            Text(
              'Due April 10, 2025 11:59 PM',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'GoogleSans',
                color: Colors.grey[400],
              ),
            ),
        
            const SizedBox(height: 20),
        
            // Task Title
            const Text(
              'Task:',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'GoogleSans',
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
        
            const SizedBox(height: 5),
        
            // Task Description
            const Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
              'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, '
              'when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'GoogleSans',
                color: Colors.white70,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
 
  Widget _buildStudentAssignment() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24,),
            const Text(
              'Assignment 1',
              style: TextStyle(
                fontSize: 38,
                fontFamily: 'GoogleSans',
                fontWeight: FontWeight.w500,
                color: Colors.white,
                height: 1
              ),
            ),
            const SizedBox(height: 32,),
            const Text(
              'Maitri Dalvi',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'GoogleSans',
                fontWeight: FontWeight.w500,
                color: Colors.white,
                height: 1
              ),
            ),
        
            // Due Date
            const SizedBox(height: 5),
            Text(
              'Due April 10, 2025 11:59 PM',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'GoogleSans',
                color: Colors.grey[400],
              ),
            ),
        
            const SizedBox(height: 20),
        
            // Task Title
            const Text(
              'Task:',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'GoogleSans',
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
        
            const SizedBox(height: 5),
        
            // Task Description
            const Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
              'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, '
              'when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'GoogleSans',
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16,),
            _buildSubmissionCard(
              name: 'Assignment0.pdf',
              rollno: '',
              onTap: () {
                setState(() {
                  openStudentAssignment = true;
                });
              },
            ),
            Text(
              'Grade: 9/10',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'GoogleSans',
                color: Colors.grey[400],
              ),
            ),
        
          ],
        ),
      ),
    );
  }
 
  Widget _buildSubmissions() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CreateCardFeature(
              imagePath: 'assets/images/kaksha.png',
              topText: 'MarkSheet',
              bottomText: '',
              buttonText: 'Download',
              height: 150,
              imageTop: -50,
              imageLeft: 100,
              imageHeight: 400,
              imageWidth: 400,
              wantImg: false,
              btFontSize: 18,
              onPressed: () {}
            ),
            const SizedBox(height: 10,),
            ...fileList.map((file) {
              return _buildSubmissionCard(
                name: file['name']!,
                rollno: file['rollno']!,
                onTap: () {
                  setState(() {
                    openStudentAssignment = true;
                  });
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmissionCard({
    required String name,
    required String rollno,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap, // This triggers when the card is tapped
      child: Container(
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
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                if(rollno.isNotEmpty)
                Text(
                  rollno,
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
              child: SvgPicture.asset(
                'assets/icons/common/play.svg',
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
  

}


