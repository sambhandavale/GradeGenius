import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';
import 'package:gradegenius/components/shared/app_bar.dart';
import 'package:gradegenius/components/shared/button.dart';
import 'package:gradegenius/components/shared/drop_down.dart';
import 'package:gradegenius/utils/constants.dart';

class QuizGeneratorPage extends StatefulWidget {
  const QuizGeneratorPage({Key? key}) : super(key: key);

  @override
  State<QuizGeneratorPage> createState() => _QuizGeneratorPageState();
}

class _QuizGeneratorPageState extends State<QuizGeneratorPage> {
  // State variables
  int _selectedTab = 0;
  String _contentText = '';
  File? _documentFile;
  int _maxQuestions = 10;
  int _timeLimit = 5;
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
    if (_selectedTab == 0 && _contentText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter some content'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    } else if (_selectedTab == 1 && _documentFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload a document'),
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
      backgroundColor: Constants.darkThemeBg,
      appBar: CustomGreetingAppBar(
        avatarImage: AssetImage('assets/images/avatar.png'),
        addLogout: true,
        hidBack:true,
      ),
      body: SafeArea(
        child:
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top:15,bottom: 100,left:30,right:30),
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
                    'Upload a document, paste your notes to automatically generate a quiz with AI.',
                    style: TextStyle(
                      color: Constants.darkThemeFontColor,
                      fontSize: 16,
                      fontFamily: 'GoogleSans',
                    ),
                  ),
                  
                  const SizedBox(height: 20),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildSlideOption(0,'Text','assets/icons/kaksha/pen.svg'),
                        const SizedBox(width: 10),
                        _buildSlideOption(1,'Document','assets/icons/kaksha/files.svg'),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 15),
                  if (_selectedTab == 0)
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C1C),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 24),
                        child: TextField(
                          controller: _contentController,
                          maxLines: null,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Paste your content here',
                            hintStyle: const TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                          ),

                          onChanged: (value) {
                            _contentText = value;
                          },
                        ),
                      ),
                    )
                  else if (_selectedTab == 1)
                    Container(
                      height: 100,
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

                  _quizOptions(),    

                  const SizedBox(height: 15),
                  IconTextButton(
                    text: 'Not Available',
                    iconPath: 'assets/icons/common/play.svg',
                    // onPressed: onGenerateQuiz,
                    onPressed: (){},
                    textColor: Colors.white,
                    iconSize: 28,
                    backgroundColor: const Color.fromARGB(255, 127, 146, 255),
                  ),
                ],
              ),
            ),
          )
      ),
    
    );
  }

  Widget _buildSlideOption(int index, String text, String logo) {
    bool isSelected = _selectedTab == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color.fromARGB(255, 255, 184, 60) : Colors.grey[800],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontFamily: 'GoogleSans',
                fontSize: 22,
              ),
            ),
            SizedBox(width: 10),
            SvgPicture.asset(
              logo,
              width: 28,
              height: 28,
            ),
          ],
        ),
      ),
    );
  }
 
  Widget _quizOptions(){
    return                   
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [                      
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
          CustomDropdownField<int>(
            value: _maxQuestions,
            hint: 'Max Questions',
            items: List.generate(10, (index) => index + 1)
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
          CustomDropdownField<int>(
            value: _timeLimit,
            hint: 'Time Limit',
            items: List.generate(10, (index) => index + 1)
                .map((int value) => DropdownMenuItem<int>(
                      value: value,
                      child: Text('$value Mins'),
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
          CustomDropdownField<String>(
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
      
        ],
      );
      
  }

}
