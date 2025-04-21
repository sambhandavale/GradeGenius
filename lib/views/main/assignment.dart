import 'dart:io';
import 'dart:math';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradegenius/api/routes/get/kaksha/assignment.dart/assignment_details.dart';
import 'package:gradegenius/api/routes/get/kaksha/assignment.dart/download_attachment.dart';
import 'package:gradegenius/api/routes/get/kaksha/assignment.dart/download_submission_file.dart';
import 'package:gradegenius/api/routes/get/kaksha/assignment.dart/submissions.dart';
import 'package:gradegenius/components/landing/feature_box.dart';
import 'package:gradegenius/components/shared/kaksha_app_bar.dart';
import 'package:gradegenius/models/assignment_details.dart';
import 'package:gradegenius/models/submissions.dart';
import 'package:gradegenius/models/users.dart';
import 'package:gradegenius/providers/authProvider.dart';
import 'package:gradegenius/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class AboutAssignment extends StatefulWidget {
  final String kakshaId;
  final int members;
  final String kakshaName;
  final String assignmentId;

  const AboutAssignment({super.key, required this.kakshaId, required this.members, required this.kakshaName, required this.assignmentId});

  @override
  _AboutAssignmentState createState() => _AboutAssignmentState();
}

enum FileAction { download, share }

class _AboutAssignmentState extends State<AboutAssignment> { 
  bool isAuth = true;
  int selectedIndex = 0;
  bool openStudentAssignment = false;
  late AssignmentDetails assignmentInfo;
  bool isLoading = true;
  List<Submission> submissionList = [];
  late Submission selectedSubmission;
  User? _user;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _user = authProvider.user;
    getAssignmentDetails();
    if(_user?.role == 'teacher'){
      getSubmissionList();
    }
  }

  String formattedDate(DateTime date) {
    final DateFormat formatter = DateFormat('MMMM dd, yyyy h:mm a');
    return formatter.format(date);
  }

  Future<void> getAssignmentDetails() async {
    try {
      final response = await assignmentDetails(widget.assignmentId);
      if (response['statusCode'] == 200) {
        final assignment = AssignmentDetails.fromJson(response['data']['assignment']);
        setState(() {
          assignmentInfo = assignment;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load assignment details');
      }
    } catch (e) {
      debugPrint('Error in getAssignmentDetails: $e');
      rethrow;
    }
  }

  Future<void> shareAttachmentFile() async {
    try {
      final response = await downloadAttachment(assignmentInfo.attachments[0].fileId);

      if (response['statusCode'] == 200) {
        final bytes = response['bytes'] as List<int>;
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/${assignmentInfo.attachments[0].filename}';

        final file = File(filePath);
        await file.writeAsBytes(bytes);

        debugPrint('File saved at: $filePath');

        await Share.shareXFiles([XFile(filePath)], text: assignmentInfo.attachments[0].filename);
      } else {
        throw Exception('Failed to download attachment');
      }
    } catch (e) {
      debugPrint('Error in downloading attachment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to share file: $e')),
      );
    }
  }

  Future<void> openAttachmentFile() async {
    try {
      final response = await downloadAttachment(assignmentInfo.attachments[0].fileId);

      if (response['statusCode'] == 200) {
        final bytes = response['bytes'] as List<int>;
        
        // Get temporary directory (better for opening files)
        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/${assignmentInfo.attachments[0].filename}';

        final file = File(filePath);
        await file.writeAsBytes(bytes);

        debugPrint('File saved at: $filePath');

        final result = await OpenFile.open(filePath);
        
        if (result.type != ResultType.done) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not open file: ${result.message}')),
          );
        }
      } else {
        throw Exception('Failed to download attachment');
      }
    } catch (e) {
      debugPrint('Error opening attachment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open file: $e')),
      );
    }
  }

  Future<void> shareSubmissionFile(
    String assignmentId,
    String studentId,
    String fileId,
    String contentType,
  ) async {
    try {
      final response = await downloadSubmissionFile(assignmentId, studentId, fileId);

      if (response['statusCode'] == 200) {
        final bytes = Uint8List.fromList(response['bytes'] as List<int>);
        final fileRecord = selectedSubmission.files[0];
        final filename = fileRecord.filename;

        final tempDir = await getTemporaryDirectory();
        final tempPath = '${tempDir.path}/$filename';
        final tempFile = File(tempPath);

        await tempFile.writeAsBytes(bytes);

        await Share.shareXFiles(
          [XFile(tempPath, name: filename, mimeType: contentType)],
          text: 'Submission file: $filename',
        );
      }
    } catch (e) {
      debugPrint('Error sharing file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  Future<void> openSubmissionFile(
    String assignmentId,
    String studentId,
    String fileId,
  ) async {
    try {
      final response = await downloadSubmissionFile(assignmentId, studentId, fileId);

      if (response['statusCode'] == 200) {
        final bytes = Uint8List.fromList(response['bytes'] as List<int>);
        final fileRecord = selectedSubmission.files[0];
        final filename = fileRecord.filename;

        final tempDir = await getTemporaryDirectory();
        final tempPath = '${tempDir.path}/$filename';
        final tempFile = File(tempPath);

        await tempFile.writeAsBytes(bytes);

        final result = await OpenFile.open(tempPath);

        if (result.type != ResultType.done) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not open file: ${result.message}')),
          );
        }
      }
    } catch (e) {
      debugPrint('Error opening file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }


  Future<void> getSubmissionList() async {
    try {
      final response = await submissionsList(widget.assignmentId);
      if (response['statusCode'] == 200) {
        final List<dynamic> data = response['data']['submissions'];
        print(data);
        var submissions = data.map((json) => Submission.fromJson(json)).toList();
        setState(() {
          submissionList = submissions;
        });
      } else {
        throw Exception('Failed to load submission list');
      }
    } catch (e) {
      debugPrint('Error in submission list: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    extendBodyBehindAppBar: true,
    backgroundColor: Constants.darkThemeBg,
    appBar: KakshaAppBar(
      kakshaName: widget.kakshaName,
      kakshaMembers: "${widget.members} Members",
      avatarImage: AssetImage('assets/images/avatar.png'),
    ),
    body: buildAssignmentControls()
  );
  
  }

  Widget buildAssignmentControls() {
    return Padding(
      padding: const EdgeInsets.only(top:110,bottom: 0, left: 40,right:40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(_user?.role == 'teacher')
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSlideOption(0,'About'),
                SizedBox(width: 10),
                _buildSlideOption(1,'Submissions'),
                SizedBox(width: 10),
              ],
            ),
          ),
          if(_user?.role == 'teacher')
          SizedBox(height: 16),
          if(openStudentAssignment && !isLoading)
          _buildStudentAssignment(),
          if(selectedIndex == 0 && !openStudentAssignment && !isLoading)
          _buildAboutAssignment(),
          if(selectedIndex == 1 && !openStudentAssignment && !isLoading)
          _buildSubmissions(),
        ],
      ),
    );
  }
 
  Widget _buildSlideOption(int index, String text) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          openStudentAssignment = false;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
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
          ],
        ),
      ),
    );
  }

  Widget _buildAboutAssignment() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24,),
            Text(
              assignmentInfo.title,
              style: TextStyle(
                fontSize: 38,
                fontFamily: 'GoogleSans',
                fontWeight: FontWeight.w500,
                color: Colors.white,
                height: 1
              ),
            ),
        
            const SizedBox(height: 5),
            Text(
              formattedDate(assignmentInfo.dueDate),
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'GoogleSans',
                color: Colors.grey[400],
              ),
            ),
        
            const SizedBox(height: 20),
            const Text(
              'Task:',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'GoogleSans',
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              assignmentInfo.description,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'GoogleSans',
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),
            _buildSubmissionCard(
              name: assignmentInfo.attachments[0].filename, 
              rollno: '', 
              onTap: (){
                // shareAttachmentFile(assignmentInfo.attachments[0].fileId);
                openAttachmentFile();
              },
              icon: 'assets/icons/common/download.svg',
              showIcon: false,
            ),
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    openAttachmentFile();
                  },
                  icon: Icon(Icons.open_in_new, color: Colors.white),
                  label: Text(
                    'Open',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'GoogleSans',
                      fontSize: 16,
                      height: 1
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                      shareAttachmentFile();
                  },
                  icon: Icon(Icons.share, color: Colors.white),
                  label: Text(
                    'Share',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'GoogleSans',
                      fontSize: 16,
                      height: 1
                    ),
                  ),
                ),
              ],
            )


          ],
        ),
      ),
    );
  }
 
  Widget _buildStudentAssignment() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24,),
            Text(
              assignmentInfo.title,
              style: TextStyle(
                fontSize: 38,
                fontFamily: 'GoogleSans',
                fontWeight: FontWeight.w500,
                color: Colors.white,
                height: 1
              ),
            ),
            const SizedBox(height: 32,),
            Text(
              selectedSubmission.student.username,
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'GoogleSans',
                fontWeight: FontWeight.w500,
                color: Colors.white,
                height: 1
              ),
            ),
        
            // Due Date
            const SizedBox(height: 5),
            Text(
              formattedDate(selectedSubmission.submittedAt),
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'GoogleSans',
                color: Colors.grey[400],
              ),
            ),
        
            const SizedBox(height: 20),
        
            // Task Title
            const Text(
              'Task:',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'GoogleSans',
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
        
            const SizedBox(height: 5),
        
            // Task Description
            Text(
              assignmentInfo.description,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'GoogleSans',
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16,),
            _buildSubmissionCard(
              name: selectedSubmission.files[0].filename,
              rollno: '',
              onTap: () {},
              icon:'assets/icons/common/download.svg'
            ),
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    openSubmissionFile(
                      assignmentInfo.id,
                      selectedSubmission.student.id,
                      selectedSubmission.files[0].fileId,
                    );
                  },
                  icon: Icon(Icons.open_in_new, color: Colors.white),
                  label: Text(
                    'Open',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'GoogleSans',
                      fontSize: 16,
                      height: 1
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    shareSubmissionFile(
                      assignmentInfo.id,
                      selectedSubmission.student.id,
                      selectedSubmission.files[0].fileId,
                      selectedSubmission.files[0].contentType
                    );
                  },
                  icon: Icon(Icons.share, color: Colors.white),
                  label: Text(
                    'Share',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'GoogleSans',
                      fontSize: 16,
                      height: 1
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Text(
              'Grade: __/10',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'GoogleSans',
                color: Colors.grey[400],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
 
  Widget _buildSubmissions() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CreateCardFeature(
              imagePath: 'assets/images/kaksha.png',
              topText: 'MarkSheet',
              bottomText: '',
              buttonText: 'Download',
              height: 150,
              imageTop: -50,
              imageLeft: 100,
              imageHeight: 400,
              imageWidth: 400,
              wantImg: false,
              btFontSize: 18,
              onPressed: () {}
            ),
            const SizedBox(height: 20,),
            ...submissionList.map((submission) {
              return _buildSubmissionCard(
                name: submission.student.username,
                rollno: formattedDate(submission.submittedAt),
                onTap: () {
                  setState(() {
                    selectedSubmission = submission;
                    openStudentAssignment = true;
                  });
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmissionCard({
    required String name,
    required String rollno,
    required VoidCallback onTap,
    String icon = 'assets/icons/common/play.svg',
    bool showIcon = true
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.length > 20 ? '${name.substring(0, min(20, name.length))}...' : name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                if(rollno.isNotEmpty)
                Text(
                  rollno,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            if(showIcon)
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.white10,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                icon,
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
  


}


