import 'package:flutter/material.dart';
import 'package:gradegenius/api/routes/put/answer_doubt.dart';
import 'package:gradegenius/components/shared/app_bar.dart';
import 'package:gradegenius/components/shared/button.dart';

class AnswerDoubt extends StatefulWidget {
  final String kakshaId;
  final String doubtId;
  final String doubt;

  const AnswerDoubt({super.key,required this.kakshaId, required this.doubtId, required this.doubt});

  @override
  _AnswerDoubtState createState() => _AnswerDoubtState();
}

class _AnswerDoubtState extends State<AnswerDoubt> {
  final _answerController = TextEditingController();
  bool _isLoading = false;

  void onSolve() async {
    final answer = _answerController.text.trim();

    if (answer.isEmpty) {
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
      "doubtId": widget.doubtId,
      "answer": answer,
    };

    final response = await answerDoubt(doubtData);
    final statusCode = response['statusCode'];
    final responseData = response['data'];

    setState(() => _isLoading = false);

    if (statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Doubt Solved!!!'),
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
              Text(
                widget.doubt,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              _buildTextField("Type the answer...", controller: _answerController, maxLines: 3),
              const SizedBox(height: 16),
              IconTextButton(
                text: _isLoading ? 'Loading...':'Solve',
                iconPath: 'assets/icons/common/play.svg',
                onPressed: onSolve,
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
