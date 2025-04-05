import 'package:flutter/material.dart';

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
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, $userName",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'GoogleSans',
                  ),
                ),
                Text(
                  userRole,
                  style: const TextStyle(
                    color: Colors.white70,
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
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
