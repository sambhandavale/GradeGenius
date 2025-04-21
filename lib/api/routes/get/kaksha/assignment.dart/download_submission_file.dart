import 'package:flutter/material.dart';
import 'package:gradegenius/api/api_service.dart';
import 'package:gradegenius/utils/constants.dart';

Future<Map<String, dynamic>> downloadSubmissionFile(String assignmentId, String studentId, String fileId) async {
  try {
    final apiService = ApiService(Constants.secureStorage, authRequired: true);
    final response = await apiService.getFileRequest('/kaksha/assignment/submissions/download?assignmentId=$assignmentId&studentId=$studentId&fileId=$fileId');

    if (response.statusCode == 200) {
      return {
        'statusCode': response.statusCode,
        'bytes': response.data,
        'headers': response.headers.map,
      };
    } else {
      throw Exception('Failed to download submission file: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error during downloading submission file: $e');
    rethrow;
  }
}


