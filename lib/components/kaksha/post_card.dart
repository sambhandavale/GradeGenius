import 'package:flutter/material.dart';
import 'package:gradegenius/components/shared/button.dart';
import 'package:gradegenius/utils/constants.dart';

class PostCard extends StatelessWidget {
  final String name;
  final String dateTime;
  final String profilePic;
  final String title;
  final String buttonText;
  final double height;
  final VoidCallback onPressed;
  final Color bgColor;

  const PostCard({
    super.key,
    required this.name,
    required this.dateTime,
    required this.profilePic,
    required this.title,
    required this.buttonText,
    this.height = 230,
    required this.onPressed,
    this.bgColor = const Color(0xFFFFEB3B),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Constants.darkThemeFontColor,
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'GoogleSans',
                              height: 1,
                            ),
                          ),
                          Text(
                            dateTime,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'GoogleSans',
                              // height: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'GoogleSans',
                        height: 1,
                      ),
                    ),
                  ),
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
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(width: 6,),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.more_vert),
                          color: Colors.white,
                          iconSize: 32,
                          onPressed: () {
                            // your action here
                          },
                        ),
                      ),

                    ],
                  )


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
