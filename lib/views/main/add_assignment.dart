import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradegenius/components/shared/app_bar.dart';
import 'package:gradegenius/components/shared/button.dart';

class AddAssignment extends StatefulWidget {
  const AddAssignment({super.key});

  @override
  _AddAssignment createState() => _AddAssignment();
}

class _AddAssignment extends State<AddAssignment> {
  bool isAuth = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 14, 14, 14),
      appBar: CustomGreetingAppBar(
        userName: "User",
        userRole: "Teacher",
        avatarImage: AssetImage('assets/images/avatar.png'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add Assignment",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildTextField("Name"),
              const SizedBox(height: 16),
              _buildTextField("Description", maxLines: 3),
              const SizedBox(height: 16),
              _buildTextFieldWithIcon("Deadline", Icons.access_time),
              const SizedBox(height: 16),
              _buildTextField("Grade"),
              const SizedBox(height: 24),
              IconTextButton(
                text: 'File Upload',
                iconPath: 'assets/icons/common/play.svg',
                onPressed:(){},
                textColor: Colors.white,
                iconSize: 36,
                fontSize: 24,
                // width: double.infinity,
              ),
              const SizedBox(height: 10,),
              IconTextButton(
                text: 'Publish',
                iconPath: 'assets/icons/common/play.svg',
                onPressed:(){},
                textColor: Colors.white,
                iconSize: 36,
                fontSize: 24,
                // width: double.infinity,
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   color: Colors.transparent,
      //   child: CustomBottomNavExample(),
      // ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color.fromARGB(255, 30, 30, 30),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildTextFieldWithIcon(String hint, IconData icon) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color.fromARGB(255, 30, 30, 30),
        suffixIcon: Icon(icon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
 
}


