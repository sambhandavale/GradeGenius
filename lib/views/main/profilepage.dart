import 'package:flutter/material.dart';
import 'package:gradegenius/components/shared/app_bar.dart';
import 'package:intl/intl.dart';
import 'package:gradegenius/providers/authProvider.dart';
import 'package:gradegenius/utils/constants.dart';
import 'package:provider/provider.dart';

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
  IconData roleIcon = Icons.person;

  @override
  void initState() {
    super.initState();
    _initializeRoleBasedSettings();
  }

  void _initializeRoleBasedSettings() {
    switch (widget.role) {
      case 'teacher':
        headerColor = const Color.fromARGB(255, 172, 67, 67);
        roleTitle = "Teacher";
        roleIcon = Icons.school;
        break;
      case 'student':
        headerColor = const Color(0xFFA7C7E0);
        roleTitle = "Student";
        roleIcon = Icons.person_outline;
        break;
      case 'admin':
        headerColor = const Color(0xFFE0A7A7);
        roleTitle = "Admin";
        roleIcon = Icons.admin_panel_settings;
        break;
      default:
        headerColor = const Color(0xFFD7D7D7);
        roleTitle = widget.role.isNotEmpty
            ? widget.role[0].toUpperCase() + widget.role.substring(1)
            : "User";
        roleIcon = Icons.person;
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final formattedDate = DateFormat('dd/MM/yyyy').format(date);
      return formattedDate;
    } catch (e) {
      return 'N/A';
    }
  }

  String _formatPhoneNumber(int phoneNumber) {
    final phoneStr = phoneNumber.toString();
    if (phoneStr.length < 10) return phoneStr;
    if (phoneStr.length == 10) {
      return '${phoneStr.substring(0, 3)} ${phoneStr.substring(3, 6)} ${phoneStr.substring(6)}';
    }
    return phoneStr;
  }

  String _formatBirthday(String bodString) {
    try {
      final bod = DateTime.parse(bodString);
      final formattedBod = DateFormat('dd/MM/yyyy').format(bod);
      return formattedBod;
    } catch (e) {
      return 'Not specified';
    }
  }

  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    if (user == null) {
      return Scaffold(
        backgroundColor: Constants.darkThemeBg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Profile",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'GoogleSans',
            ),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final firstName = user.firstName;
    final lastName = user.lastName;
    final fullName = "$firstName $lastName";
    final hasFullName = firstName.isNotEmpty || lastName.isNotEmpty;

    return Scaffold(
      backgroundColor: Constants.darkThemeBg,
      appBar: CustomGreetingAppBar(
        avatarImage: const AssetImage('assets/images/avatar.png'),
        addLogout: true,
        hidBack: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            // Header with gradient background
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [headerColor.withOpacity(0.8), headerColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: headerColor.withOpacity(0.6),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Role icon and title
                  Positioned(
                    top: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          roleIcon,
                          color: Colors.white.withOpacity(0.3),
                          size: 60,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          roleTitle,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 18,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Profile picture (constant avatar)
                  Positioned(
                    bottom: -60,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: headerColor.withOpacity(0.3),
                        backgroundImage: const AssetImage('assets/default.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),

            // Profile Info Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  // Name and username
                  if (hasFullName)
                    Text(
                      fullName,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'GoogleSans',
                      ),
                    ),
                  if (!hasFullName)
                    Text(
                      user.username,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'GoogleSans',
                      ),
                    ),
                  if (user.designation.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      user.designation,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontFamily: 'GoogleSans',
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  if (user.username.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: headerColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        '@${user.username}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'GoogleSans',
                        ),
                      ),
                    ),
                  const SizedBox(height: 30),

                  // Basic Information Section
                  _buildSectionHeader('Basic Information', headerColor),
                  const SizedBox(height: 15),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    color: Colors.white.withOpacity(0.05),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          if (hasFullName)
                            _buildInfoItem(Icons.person, 'Full Name', fullName),
                          if (user.username.isNotEmpty)
                            _buildInfoItem(Icons.alternate_email, 'Username', user.username),
                          if (user.designation.isNotEmpty)
                            _buildInfoItem(Icons.work, 'Designation', user.designation),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Contact Information Section
                  _buildSectionHeader('Contact Information', headerColor),
                  const SizedBox(height: 15),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    color: Colors.white.withOpacity(0.05),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          if (user.email.isNotEmpty)
                            _buildInfoItem(Icons.email, 'Email', user.email),
                          if (user.mobileNumber != 0)
                            _buildInfoItem(Icons.phone, 'Phone', _formatPhoneNumber(user.mobileNumber)),
                          if (user.email.isEmpty && user.mobileNumber == 0)
                            _buildEmptyInfoMessage("No contact information available."),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Personal Information Section
                  _buildSectionHeader('Personal Information', headerColor),
                  const SizedBox(height: 15),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    color: Colors.white.withOpacity(0.05),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          if (user.gender.isNotEmpty)
                            _buildInfoItem(Icons.person, 'Gender', user.gender),
                          if (user.bod.isNotEmpty && user.bod != "null")
                            _buildInfoItem(Icons.cake, 'Birthday', _formatBirthday(user.bod)),
                          if (user.teams.isNotEmpty)
                            _buildInfoItem(Icons.group, 'Teams', user.teams.join(', ')),
                          if (user.bio.isNotEmpty)
                            _buildBioItem(user.bio),
                          if (user.gender.isEmpty && (user.bod.isEmpty || user.bod == "null") &&
                              user.teams.isEmpty && user.bio.isEmpty)
                            _buildEmptyInfoMessage("No personal information available."),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Account Information
                  _buildSectionHeader('Account Information', headerColor),
                  const SizedBox(height: 15),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    color: Colors.white.withOpacity(0.05),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          if (user.createdAt.isNotEmpty)
                            _buildInfoItem(
                              Icons.calendar_today,
                              'Joined On',
                              _formatDate(user.createdAt),
                            ),
                          if (user.status.isNotEmpty)
                            _buildInfoItem(
                              Icons.circle,
                              'Account Status',
                              user.status,
                              valueColor: user.status.toLowerCase() == 'inactive'
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                          if (user.status.isEmpty)
                            _buildInfoItem(
                              Icons.circle,
                              'Account Status',
                              "Active",
                              valueColor: Colors.green,
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'GoogleSans',
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        const Divider(color: Colors.white24),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: headerColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: headerColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: 'GoogleSans',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: valueColor ?? Colors.white,
                    fontFamily: 'GoogleSans',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBioItem(String bio) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: headerColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.description,
              color: headerColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bio',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: 'GoogleSans',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  bio,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'GoogleSans',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyInfoMessage(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[400],
            fontStyle: FontStyle.italic,
            fontFamily: 'GoogleSans',
          ),
        ),
      ),
    );
  }
}