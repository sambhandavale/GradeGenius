import 'package:flutter/material.dart';
import 'package:gradegenius/utils/constants.dart';

class PPTAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PPTAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Hello, User",
                    style: TextStyle(
                      color: Constants.darkThemeFontColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'GoogleSans',
                    ),
                  ),
                  Text(
                    "Student",
                    style: TextStyle(
                      color: Constants.darkThemeFontColor,
                      fontSize: 14,
                      fontFamily: 'GoogleSans',
                    ),
                  ),
                ],
              ),
            ),
            const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.grey,
              // backgroundImage: NetworkImage('your_profile_image_url'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}