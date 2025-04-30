import 'package:flutter/material.dart';
import 'package:gradegenius/components/shared/button.dart';
import 'package:gradegenius/components/shared/truncate_text.dart';
import 'package:gradegenius/providers/authProvider.dart';
import 'package:gradegenius/utils/constants.dart';
import 'package:gradegenius/utils/general.dart';
import 'package:provider/provider.dart';

class PostCard extends StatelessWidget {
  final String name;
  final String dateTime;
  final String profilePic;
  final String title;
  final String buttonText;
  final VoidCallback onPressed;
  final Color bgColor;
  final String type;

  final int? plus1;
  final String? doubtId;
  final Function(String doubtId)? onUpvote;
  final String? answer;

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

    this.plus1,
    this.doubtId,
    this.onUpvote,
    this.answer,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final _user = authProvider.user;
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
                      truncateText(name, 13),
                      style: const TextStyle(
                        fontSize: 28,
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
              child: ExpandableText(
                title: title,
                maxLength:50
              )
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
            if(type == 'doubt')
            Row(
              children: [
                Expanded(
                  child: IconTextButton(
                    text: buttonText,
                    iconPath: 'assets/icons/common/play.svg',
                    onPressed: buttonText != 'Solved' ? onPressed : (){},
                    textColor: Colors.white,
                    iconSize: 36,
                    fontSize: 24,
                    backgroundColor: const Color.fromARGB(255, 10, 10, 10),
                    width: 'max',
                  ),

                ),
                if(buttonText == 'Solved')
                const SizedBox(width: 6),
                if(buttonText == 'Solved')
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.white,
                    iconSize: 32,
                    onPressed: onPressed,
                  ),

                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () {
                    if (onUpvote != null && _user?.role != 'teacher') {
                      onUpvote!(doubtId!);
                    }
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 18, bottom: 18, right: 12, left: 10),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Text(
                          '+1',
                          style: TextStyle(
                            fontSize: 24,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'GoogleSans',
                            height: 1,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -8,
                        right: -6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '+$plus1',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'GoogleSans',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                // const SizedBox(width: 6),
                // Container(
                //   padding: const EdgeInsets.symmetric(vertical: 6),
                //   decoration: BoxDecoration(
                //     color: Colors.black,
                //     borderRadius: BorderRadius.circular(40),
                //   ),
                //   child: IconButton(
                //     icon: const Icon(Icons.more_vert),
                //     color: Colors.white,
                //     iconSize: 32,
                //     onPressed: () {
                //       // Your action here
                //     },
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 16),
            if(type == 'doubt' && answer!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ExpandableText(
                title: 'Solution: $answer',
                maxLength:50
              )
            ),
          ],
        ),
      ),
    );
  }
}
