import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gradegenius/components/shared/app_bar.dart';
import 'package:gradegenius/components/shared/button.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class AddAssignment extends StatefulWidget {
  final String kakshaId;

  const AddAssignment({super.key,required this.kakshaId});

  @override
  _AddAssignmentState createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _dueDate;
  List<PlatformFile> _files = [];
  final _secureStorage = FlutterSecureStorage();

  Future<Uint8List?> _loadFileBytes(PlatformFile file) async {
    if (file.bytes != null) return file.bytes;
    if (file.path != null) {
      try {
        return await File(file.path!).readAsBytes();
      } catch (e) {
        print('Error reading file: $e');
        return null;
      }
    }
    return null;
  }

  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null) {
        List<PlatformFile> loadedFiles = [];

        for (PlatformFile file in result.files) {
          // For mobile platforms where bytes are null but path exists
          if (file.bytes == null && file.path != null) {
            try {
              final fileData = await File(file.path!).readAsBytes();
              loadedFiles.add(PlatformFile(
                name: file.name,
                size: file.size,
                bytes: fileData,
                path: file.path,
              ));
            } catch (e) {
              print('Error loading file ${file.name}: $e');
            }
          } 
          // For web/desktop where bytes might be available
          else if (file.bytes != null) {
            loadedFiles.add(file);
          }
        }

        setState(() {
          _files = loadedFiles;
        });

        // Debug print to verify files
        print('Loaded files:');
        for (var f in _files) {
          print('${f.name} - bytes: ${f.bytes != null ? f.bytes!.length : "null"}');
        }
      }
    } catch (e) {
      print('File picking error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting files: $e')),
      );
    }
  }
    
  Future<void> _submitAssignment() async {
    if (_titleController.text.isEmpty || 
        _descriptionController.text.isEmpty || 
        _dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final token = await _secureStorage.read(key: 'jwt');
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication required')),
      );
      return;
    }

    try {
      var dio = Dio();
      var formData = FormData.fromMap({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'dueDate': _dueDate!.toIso8601String(),
        'kaksha': widget.kakshaId,
      });

      // Handle file uploads with proper content types
      for (var file in _files) {
        // Determine content type based on file extension
        String contentType = 'application/octet-stream'; // default
        if (file.name.toLowerCase().endsWith('.jpg') || file.name.toLowerCase().endsWith('.jpeg')) {
          contentType = 'image/jpeg';
        } else if (file.name.toLowerCase().endsWith('.png')) {
          contentType = 'image/png';
        } else if (file.name.toLowerCase().endsWith('.pdf')) {
          contentType = 'application/pdf';
        } else if (file.name.toLowerCase().endsWith('.docx')) {
          contentType = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
        }

        if (file.bytes != null) {
          formData.files.add(MapEntry(
            'files',
            MultipartFile.fromBytes(
              file.bytes!,
              filename: file.name,
              contentType: MediaType.parse(contentType),
            ),
          ));
        } else if (file.path != null) {
          formData.files.add(MapEntry(
            'files',
            await MultipartFile.fromFile(
              file.path!,
              filename: file.name,
              contentType: MediaType.parse(contentType),
            ),
          ));
        }
      }

      var response = await dio.post(
        'http://192.168.31.20:6000/api/kaksha/assignment/create',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Assignment created successfully')),
        );
        // Clear form after successful submission
        _titleController.clear();
        _descriptionController.clear();
        setState(() {
          _dueDate = null;
          _files = [];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Submission error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit: ${e.toString()}')),
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
                "Add Assignment",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              _buildTextField("Name", controller: _titleController),
              const SizedBox(height: 16),
              _buildTextField("Description", controller: _descriptionController, maxLines: 3),
              const SizedBox(height: 16),
              _buildDatePicker(),
              const SizedBox(height: 24),
              IconTextButton(
                text: 'File Upload',
                iconPath: 'assets/icons/common/play.svg',
                onPressed: _pickFiles,
                textColor: Colors.white,
                iconSize: 36,
                fontSize: 20,
              ),
              if (_files.isNotEmpty)
                Column(
                  children: _files.map((file) => ListTile(
                    leading: Icon(Icons.insert_drive_file),
                    title: Text(file.name),
                    subtitle: Text(
                      '${file.size} bytes - '
                      '${file.bytes != null ? "Ready" : "Error: No bytes"}'
                    ),
                  )).toList(),
                ),
              const SizedBox(height: 16),
              IconTextButton(
                text: 'Publish',
                iconPath: 'assets/icons/common/play.svg',
                onPressed: _submitAssignment,
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

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 1)),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() {
            _dueDate = pickedDate;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 30, 30, 30),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _dueDate == null
                  ? "Select Deadline"
                  : "Deadline: ${_dueDate!.toLocal().toString().split(' ')[0]}",
              style: const TextStyle(color: Colors.white),
            ),
            const Icon(Icons.calendar_today, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
