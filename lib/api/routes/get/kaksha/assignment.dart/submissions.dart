import 'package:flutter/material.dart';
import 'package:gradegenius/api/api_service.dart';
import 'package:gradegenius/utils/constants.dart';

Future<Map<String, dynamic>> submissionsList(String assignmentId) async {
  try {
    final apiService = ApiService(Constants.secureStorage,authRequired: true);
    final response = await apiService.getRequest('/kaksha/assignment/list-assignments?assignmentId=$assignmentId');

    if (response.statusCode == 200) {
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } else {
      throw Exception('Failed to fetch all submissions: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error during fetching all submissions: $e');
    rethrow;
  }
}
