import 'package:flutter/material.dart';
import 'package:gradegenius/components/shared/button.dart';
import 'package:gradegenius/utils/constants.dart';

class PostCard extends StatelessWidget {
  final String name;
  final String dateTime;
  final String profilePic;
  final String title;
  final String buttonText;
  final VoidCallback onPressed;
  final Color bgColor;
  final String type;

  const PostCard({
    super.key,
    required this.name,
    required this.dateTime,
    required this.profilePic,
    required this.title,
    required this.buttonText,
    required this.onPressed,
    this.bgColor = const Color(0xFFFFEB3B),
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor,
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Constants.darkThemeFontColor,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'GoogleSans',
                        height: 1,
                      ),
                    ),
                    Text(
                      dateTime,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'GoogleSans',
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'GoogleSans',
                  height: 1,
                ),
              ),
            ),

            const SizedBox(height: 16),

            if(type == 'assignment')
            Row(
              children: [
                Expanded(
                  child: IconTextButton(
                    text: buttonText,
                    iconPath: 'assets/icons/common/play.svg',
                    onPressed: onPressed,
                    textColor: Colors.white,
                    iconSize: 36,
                    fontSize: 24,
                    backgroundColor: const Color.fromARGB(255, 10, 10, 10),
                    width: 'max',
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.more_vert),
                    color: Colors.white,
                    iconSize: 32,
                    onPressed: () {
                      // Your action here
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
