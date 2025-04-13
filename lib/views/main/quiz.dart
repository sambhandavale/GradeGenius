import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:gradegenius/components/shared/app_bar.dart';
import 'package:gradegenius/components/shared/bottom_nav.dart';
import 'package:gradegenius/components/shared/button.dart';
import 'package:gradegenius/utils/constants.dart';

class QuizGeneratorPage extends StatefulWidget {
  const QuizGeneratorPage({Key? key}) : super(key: key);

  @override
  State<QuizGeneratorPage> createState() => _QuizGeneratorPageState();
}

class _QuizGeneratorPageState extends State<QuizGeneratorPage> {
  // State variables
  String _selectedTab = 'Text';
  String _contentText = '';
  File? _documentFile;
  int _maxQuestions = 10;
  int _timeLimit = 30; // in seconds
  String _quizType = 'Multiple Choice';
  
  // Input content controller
  final TextEditingController _contentController = TextEditingController();

  // Quiz type options
  final List<String> _quizTypeOptions = [
    'Multiple Choice',
    'True/False',
    'Fill in the Blank',
    'Short Answer',
    'Matching'
  ];

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  // Function to pick document
  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
    );

    if (result != null) {
      setState(() {
        _documentFile = File(result.files.single.path!);
      });
    }
  }

  void onGenerateQuiz() {
    // Handle quiz generation logic
    if (_selectedTab == 'Text' && _contentText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter some content'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    } else if (_selectedTab == 'Document' && _documentFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload a document'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Navigate to next screen or process the quiz
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Constants.darkThemeBg,
      appBar: CustomGreetingAppBar(
        userName: "User",
        userRole: "Student",
        avatarImage: AssetImage('assets/images/avatar.png'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'AI Quiz Generator',
                style: TextStyle(
                  color: Constants.darkThemeFontColor,
                  fontSize: 32,
                  fontFamily: 'GoogleSans',
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const SizedBox(height: 10),
              
              const Text(
                'Upload a document, paste your notes, or select a video to automatically generate a quiz with AI.',
                style: TextStyle(
                  color: Constants.darkThemeFontColor,
                  fontSize: 16,
                  fontFamily: 'GoogleSans',
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Tabs for Text/Document
              Row(
                children: [
                  _buildTabButton('Text'),
                  const SizedBox(width: 10),
                  _buildTabButton('Document'),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
              
              const SizedBox(height: 15),
              
              // Content input area
              if (_selectedTab == 'Text')
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C1C),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: _contentController,
                      maxLines: null,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Paste your content here',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                        icon: Icon(Icons.paste, color: Colors.white54),
                      ),
                      onChanged: (value) {
                        _contentText = value;
                      },
                    ),
                  ),
                )
              else if (_selectedTab == 'Document')
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C1C),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _documentFile != null
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.description, color: Colors.blue),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      _documentFile!.path.split('/').last,
                                      style: const TextStyle(color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close, color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        _documentFile = null;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: _pickDocument,
                                icon: const Icon(Icons.upload_file),
                                label: const Text('Upload Document'),
                              ),
                            ),
                    ],
                  ),
                ),
              
              const SizedBox(height: 20),
              
              // Options section
              const Text(
                'Options',
                style: TextStyle(
                  color: Constants.darkThemeFontColor,
                  fontSize: 24,
                  fontFamily: 'GoogleSans',
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const SizedBox(height: 15),
              
              // Max Questions Dropdown
              _CustomDropdownField<int>(
                value: _maxQuestions,
                hint: 'Max Questions',
                items: List.generate(20, (index) => index + 1)
                    .map((int value) => DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value Questions'),
                        ))
                    .toList(),
                onChanged: (int? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _maxQuestions = newValue;
                    });
                  }
                },
              ),
              
              const SizedBox(height: 15),
              
              // Time Limit Dropdown with timer icon
              _CustomDropdownField<int>(
                value: _timeLimit,
                hint: 'Time Limit',
                items: List.generate(60, (index) => index + 1)
                    .map((int value) => DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value seconds'),
                        ))
                    .toList(),
                onChanged: (int? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _timeLimit = newValue;
                    });
                  }
                },
                suffix: const Icon(Icons.timer, color: Colors.white),
              ),
              
              const SizedBox(height: 15),
              
              // Quiz Type Dropdown
              _CustomDropdownField<String>(
                value: _quizType,
                hint: 'Type',
                items: _quizTypeOptions
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _quizType = newValue;
                    });
                  }
                },
              ),
              
              const SizedBox(height: 30),
              
              // Next Button using the shared button component
              Center(
                child: IconTextButton(
                  text: 'Next',
                  iconPath: 'assets/icons/common/play.svg',
                  onPressed: onGenerateQuiz,
                  textColor: Colors.white,
                  iconSize: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build tab buttons
  Widget _buildTabButton(String text) {
    final isSelected = _selectedTab == text;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.amber : const Color(0xFF1C1C1C),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () {
        setState(() {
          _selectedTab = text;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'GoogleSans',
        ),
      ),
    );
  }
}

// Custom Dropdown Field similar to _CustomInputField in the reference code
class _CustomDropdownField<T> extends StatelessWidget {
  final String hint;
  final T value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final Widget? suffix;

  const _CustomDropdownField({
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                dropdownColor: const Color(0xFF1C1C1C),
                isExpanded: suffix == null,
                value: value,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'GoogleSans',
                ),
                hint: Text(
                  hint,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontFamily: 'GoogleSans',
                  ),
                ),
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                items: items,
                onChanged: onChanged,
              ),
            ),
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}