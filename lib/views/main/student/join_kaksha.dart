import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradegenius/api/routes/post/kaksha/join_kaksha.dart';
import 'package:gradegenius/components/shared/app_bar.dart';
import 'package:gradegenius/components/shared/button.dart';
import 'package:gradegenius/utils/constants.dart';

class JoinKaksha extends StatefulWidget {
  final VoidCallback? goToAllKaksha;

  const JoinKaksha({super.key, this.goToAllKaksha}); 

  @override
  _JoinKakshaState createState() => _JoinKakshaState();
}

class _JoinKakshaState extends State<JoinKaksha> {
  final TextEditingController kakshacodeController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    kakshacodeController.dispose();
    super.dispose();
  }

  void onCreate() async {
    final kakshacode = kakshacodeController.text.trim();

    if (kakshacode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final kakshaData = {
      "kakshacode": kakshacode,
    };

    final response = await joinKaksha(kakshaData);
    final statusCode = response['statusCode'];
    final responseData = response['data'];

    setState(() => _isLoading = false);

    if (statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kaksha joined successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      if (widget.goToAllKaksha != null) {
        widget.goToAllKaksha!();
      } else {
        Navigator.of(context).pop('goToAllKaksha');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseData['message'].toString()),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Constants.darkThemeBg,
      appBar: CustomGreetingAppBar(
        avatarImage: const AssetImage('assets/images/avatar.png'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Join Kaksha',
                style: TextStyle(
                  color: Constants.darkThemeFontColor,
                  fontSize: 32,
                  fontFamily: 'GoogleSans',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              _CustomInputField(
                hint: "Kaksha Code",
                controller: kakshacodeController,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : IconTextButton(
                      text: 'Join',
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
