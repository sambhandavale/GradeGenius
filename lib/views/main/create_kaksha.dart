import 'package:flutter/material.dart';
import 'package:gradegenius/components/shared/app_bar.dart';

class CreateKaksha extends StatefulWidget {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 14, 14, 14),
      appBar: CustomGreetingAppBar(
        userName: "User",
        userRole: "Teacher",
        avatarImage: const AssetImage('assets/images/avatar.png'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create Kaksha',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
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
                ElevatedButton.icon(
                  onPressed: onCreate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7DDB8D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  icon: const Icon(Icons.play_arrow, color: Colors.white),
                  label: const Text(
                    "Create",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
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
