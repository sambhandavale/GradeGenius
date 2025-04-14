import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradegenius/components/shared/app_bar.dart';
import 'package:gradegenius/components/shared/button.dart';
import 'package:gradegenius/utils/constants.dart';
// import 'package:iconsax/iconsax.dart';

class PresentationPage extends StatefulWidget {
  const PresentationPage({super.key});

  @override
  State<PresentationPage> createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  int selectedIndex = 1;
  bool isNotesSelected = false;

  final TextEditingController linkController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void toggleTab(bool notes) {
    setState(() {
      isNotesSelected = notes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.darkThemeBg,
      appBar: CustomGreetingAppBar(
        userName: "User",
        userRole: "Teacher",
        avatarImage: AssetImage('assets/images/avatar.png'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildSlideOption(0,'Presentation','assets/icons/kaksha/posts.svg'),
                  SizedBox(width: 10),
                  _buildSlideOption(1,'Notes','assets/icons/kaksha/files.svg'),
                  SizedBox(width: 10),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF2B2B2B),
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextField(
                controller: linkController,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'GoogleSans',
                ),
                decoration: const InputDecoration.collapsed(
                  hintText: 'Add reference link',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'GoogleSans',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            _buildContentAdd(),
            const SizedBox(height: 20),

            IconTextButton(
              text: 'Generate',
              iconPath: 'assets/icons/common/play.svg',
              onPressed: (){},
              textColor: Colors.white,
              iconSize: 36,
              fontSize: 24,
              backgroundColor: const Color.fromARGB(255, 93, 150, 255),
              // width: double.infinity,
            ),
          ],
        ),
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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
 
  Widget _buildContentAdd(){
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 49, 49, 49),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: contentController,
                maxLines: 10,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'GoogleSans',
                ),
                decoration: const InputDecoration.collapsed(
                  hintText: 'Paste your content here',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'GoogleSans',
                  ),
                ),
              ),
            ),
          ],
        ),
      );
        
  }

}