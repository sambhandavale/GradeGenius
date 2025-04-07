import 'package:flutter/material.dart';
import 'package:gradegenius/utils/constants.dart';

class KakshaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String kakshaName;
  final String kakshaMembers;
  final ImageProvider avatarImage;

  const KakshaAppBar({
    super.key,
    required this.kakshaName,
    required this.kakshaMembers,
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
        padding: const EdgeInsets.only(right:10, left:10,top:10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              // backgroundImage: avatarImage,
              backgroundColor: Constants.darkThemeFontColor,
            ),
            const SizedBox(width: 9,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kakshaName,
                  style: const TextStyle(
                    color: Constants.darkThemeFontColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'GoogleSans',
                  ),
                ),
                Text(
                  kakshaMembers,
                  style: const TextStyle(
                    color: Constants.darkThemeFontColor,
                    fontSize: 14,
                    fontFamily: 'GoogleSans',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
