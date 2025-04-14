import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradegenius/components/shared/app_bar.dart';
import 'package:gradegenius/components/shared/button.dart';
import 'package:gradegenius/utils/constants.dart';

class CreateKaksha extends StatefulWidget {
  final VoidCallback? goToAllKaksha;

  const CreateKaksha({super.key, this.goToAllKaksha}); 

  @override
  _CreateKakshaState createState() => _CreateKakshaState();
}


class _CreateKakshaState extends State<CreateKaksha> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    aboutController.dispose();
    super.dispose();
  }

  void onCreate() {
    final name = nameController.text.trim();
    final about = aboutController.text.trim();

    if (name.isEmpty || about.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    Navigator.of(context).pop('goToAllKaksha');
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    extendBodyBehindAppBar: true,
    backgroundColor: Constants.darkThemeBg,
    appBar: CustomGreetingAppBar(
      userName: "User",
      userRole: "Teacher",
      avatarImage: AssetImage('assets/images/avatar.png'),
    ),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Kaksha',
              style: TextStyle(
                color: Constants.darkThemeFontColor,
                fontSize: 32,
                fontFamily: 'GoogleSans',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            _CustomInputField(
              hint: "Kaksha name",
              controller: nameController,
            ),
            const SizedBox(height: 15),
            _CustomInputField(
              hint: "About Kaksha",
              controller: aboutController,
            ),
            const SizedBox(height: 20),
            IconTextButton(
              text: 'Create',
              iconPath: 'assets/icons/common/play.svg',
              onPressed: onCreate,
              textColor: Colors.white,
              iconSize: 28,
            ),
          ],
        ),
      ),
    ),
  
  );
  
  }
}

class _CustomInputField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const _CustomInputField({
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF1C1C1C),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}
