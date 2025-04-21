import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradegenius/api/routes/get/auth/logout.dart';
import 'package:gradegenius/providers/authProvider.dart';
import 'package:gradegenius/utils/constants.dart';
import 'package:gradegenius/views/auth/home.dart';
import 'package:provider/provider.dart';

class CustomGreetingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ImageProvider avatarImage;
  final bool addLogout;
  final bool hidBack;

  const CustomGreetingAppBar({
    super.key,
    required this.avatarImage,
    this.addLogout = false,
    this.hidBack = false,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    final userName = user?.username ?? "User";
    final userRole = user?.role ?? "Role";

    return AppBar(
      automaticallyImplyLeading: !hidBack,
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Constants.darkThemeFontColor,
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 0, left: 10, top: 20, bottom: 20),
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
                  userRole[0].toUpperCase() + userRole.substring(1),
                  style: const TextStyle(
                    color: Constants.darkThemeFontColor,
                    fontSize: 14,
                    fontFamily: 'GoogleSans',
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (!addLogout)
              CircleAvatar(
                radius: 20,
                backgroundImage: avatarImage,
                backgroundColor: Constants.darkThemeFontColor,
              ),
            if (addLogout)
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await logout();
                  authProvider.logout();
                  Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                tooltip: "Logout",
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
