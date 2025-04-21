import 'package:flutter/material.dart';
import 'package:gradegenius/api/api_exception.dart';
import 'package:gradegenius/api/api_service.dart';
import 'package:gradegenius/utils/constants.dart';

Future<Map<String, dynamic>> signup(Map<String, dynamic> data) async {
  try {
    final apiService = ApiService(Constants.secureStorage);
    final response = await apiService.postRequest('/auth/signup', data);

    return {
      'statusCode': response.statusCode,
      'data': response.data,
    };
  } catch (e) {
    if (e is ApiException) {
      return {
        'statusCode': e.statusCode ?? 500,
        'data': e.data ?? 'Unknown error occurred',
      };
    } else {
      debugPrint('Error during registration: $e');
      return {
        'statusCode': 500,
        'data': 'Something went wrong. Please try again later.',
      };
    }
  }
}
