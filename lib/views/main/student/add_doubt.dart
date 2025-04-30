import 'package:flutter/material.dart';
import 'package:gradegenius/api/routes/post/kaksha/add_doubt.dart';
import 'package:gradegenius/components/shared/app_bar.dart';
import 'package:gradegenius/components/shared/button.dart';

class AddDoubt extends StatefulWidget {
  final String kakshaId;

  const AddDoubt({super.key,required this.kakshaId});

  @override
  _AddDoubtState createState() => _AddDoubtState();
}

class _AddDoubtState extends State<AddDoubt> {
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  void onCreate() async {
    final description = _descriptionController.text.trim();

    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final doubtData = {
      "kakshaId": widget.kakshaId,
      "question": description,
    };

    final response = await createDoubt(doubtData);
    final statusCode = response['statusCode'];
    final responseData = response['data'];

    setState(() => _isLoading = false);

    if (statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Doubt Asked!!!'),
          backgroundColor: Colors.green,
        ),
      );
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
      backgroundColor: const Color.fromARGB(255, 14, 14, 14),
      appBar: CustomGreetingAppBar(
        avatarImage: AssetImage('assets/images/avatar.png'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ask Your Doubt",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              _buildTextField("Description", controller: _descriptionController, maxLines: 3),
              const SizedBox(height: 16),
              IconTextButton(
                text: _isLoading ? 'Loading...':'Ask',
                iconPath: 'assets/icons/common/play.svg',
                onPressed: onCreate,
                textColor: Colors.white,
                iconSize: 36,
                fontSize: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1, TextEditingController? controller}) {
    return TextField(
      controller: controller,
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
}
