import 'package:flutter/material.dart';
import 'package:gradegenius/api/api_service.dart';
import 'package:gradegenius/utils/constants.dart';

Future<Map<String, dynamic>> allKaksha() async {
  try {
    final apiService = ApiService(Constants.secureStorage,authRequired: true);
    final response = await apiService.getRequest('/kaksha/all-kaksha');

    if (response.statusCode == 200) {
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } else {
      throw Exception('Failed to fetch all kaksha: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error during fetching all kaksha: $e');
    rethrow;
  }
}
