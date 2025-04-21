import 'package:flutter/material.dart';
import 'package:gradegenius/api/api_service.dart';
import 'package:gradegenius/utils/constants.dart';

Future<Map<String, dynamic>> downloadAttachment(String fileId) async {
  try {
    final apiService = ApiService(Constants.secureStorage, authRequired: true);
    final response = await apiService.getFileRequest('/kaksha/assignment/attachment/$fileId');

    if (response.statusCode == 200) {
      return {
        'statusCode': response.statusCode,
        'bytes': response.data,
        'headers': response.headers.map,
      };
    } else {
      throw Exception('Failed to download attachment: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error during downloading attachment: $e');
    rethrow;
  }
}


