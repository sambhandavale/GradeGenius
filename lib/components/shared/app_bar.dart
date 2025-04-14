import 'package:flutter/material.dart';
import 'package:gradegenius/utils/constants.dart';

class CustomGreetingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String userRole;
  final ImageProvider avatarImage;

  const CustomGreetingAppBar({
    super.key,
    required this.userName,
    required this.userRole,
    required this.avatarImage,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Constants.darkThemeFontColor,
      ),
      title: Padding(
        padding: const EdgeInsets.only(right:10, left:10,top:20, bottom:20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, $userName",
                  style: const TextStyle(
                    color: Constants.darkThemeFontColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'GoogleSans',
                  ),
                ),
                Text(
                  userRole,
                  style: const TextStyle(
                    color: Constants.darkThemeFontColor,
                    fontSize: 14,
                    fontFamily: 'GoogleSans',
                  ),
                ),
              ],
            ),
            const Spacer(),
            CircleAvatar(
              radius: 20,
              // backgroundImage: avatarImage,
              backgroundColor: Constants.darkThemeFontColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
