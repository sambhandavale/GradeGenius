import 'package:flutter/material.dart';
import 'package:gradegenius/components/shared/app_bar.dart';
import 'package:intl/intl.dart';  // Import the intl package for date formatting
import 'package:gradegenius/providers/authProvider.dart';
import 'package:provider/provider.dart';
import 'package:gradegenius/utils/constants.dart';

class ProfilePage extends StatefulWidget {
  final String role;

  const ProfilePage({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Color headerColor;
  late String roleTitle;

  @override
  void initState() {
    super.initState();
    _initializeRoleBasedSettings();
  }

  void _initializeRoleBasedSettings() {
    switch (widget.role) {
      case 'teacher':
        headerColor = const Color(0xFFB4E0A7);
        roleTitle = "Teacher";
        break;
      case 'student':
        headerColor = const Color(0xFFA7C7E0);
        roleTitle = "Student";
        break;
      case 'admin':
        headerColor = const Color(0xFFE0A7A7);
        roleTitle = "Admin";
        break;
      default:
        headerColor = const Color(0xFFD7D7D7);
        roleTitle = widget.role.isNotEmpty
            ? widget.role[0].toUpperCase() + widget.role.substring(1)
            : "User";
    }
  }

  String _getInitials(String firstName, String lastName) {
    String initials = '';
    if (firstName.isNotEmpty) initials += firstName[0].toUpperCase();
    if (lastName.isNotEmpty) initials += lastName[0].toUpperCase();
    return initials.isEmpty ? '?' : initials;
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final formattedDate = DateFormat('dd/MM/yyyy').format(date);
      return formattedDate;
    } catch (e) {
      return '';  // Return empty string if the date format is invalid
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final firstName = user.firstName;
    final lastName = user.lastName;

    return Scaffold(
      backgroundColor: Constants.darkThemeBg,
      appBar: CustomGreetingAppBar(
        avatarImage: AssetImage('assets/images/avatar.png'),
        addLogout: true,
        hidBack: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Header background
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: headerColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                // Avatar
                Positioned(
                  bottom: -60,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    backgroundImage: user.userPhoto.isNotEmpty
                        ? NetworkImage(user.userPhoto)
                        : null,
                    child: user.userPhoto.isEmpty
                        ? Text(
                            _getInitials(firstName, lastName),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'GoogleSans',
                            ),
                          )
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),

            // Username below the profile picture
            Text(
              user.username,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: 'GoogleSans',
              ),
            ),
            const SizedBox(height: 8),

            // Role
            Text(
              roleTitle,
              style: const TextStyle(
                fontSize: 22,
                color: Color.fromARGB(255, 208, 204, 204),
                fontWeight: FontWeight.normal,
                fontFamily: 'GoogleSans',
              ),
            ),
            const SizedBox(height: 10),

            // Email
            Text(
              user.email,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontFamily: 'GoogleSans',
              ),
            ),
            const SizedBox(height: 10),

            // Created on (formatted date)
            Text(
              "Created on: ${_formatDate(user.createdAt)}",  // Displaying formatted date
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontFamily: 'GoogleSans',
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}