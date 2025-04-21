import 'package:flutter/material.dart';
import 'package:gradegenius/api/api_service.dart';
import 'package:gradegenius/utils/constants.dart';

Future<Map<String, dynamic>> getUser() async {
  try {
    final apiService = ApiService(Constants.secureStorage,authRequired: true);
    final response = await apiService.getRequest('/user/me');

    if (response.statusCode == 200) {
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } else {
      throw Exception('Failed to fetch user details: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error during fetching user details: $e');
    rethrow;
  }
}
