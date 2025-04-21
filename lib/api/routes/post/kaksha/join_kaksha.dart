import 'package:flutter/material.dart';
import 'package:gradegenius/api/api_exception.dart';
import 'package:gradegenius/api/api_service.dart';
import 'package:gradegenius/utils/constants.dart';

Future<Map<String, dynamic>> joinKaksha(Map<String, dynamic> data) async {
  try {
    final apiService = ApiService(Constants.secureStorage,authRequired: true);
    final response = await apiService.postRequest('/kaksha/join-kaksha', data);
    return {
      'statusCode': response.statusCode,
      'data': response.data,
    };
  } catch (e) {
    if (e is ApiException) {
      // Handle ApiException and return the response details
      debugPrint('Error during joining kaksha: ${e.statusCode}');
      return {
        'statusCode': e.statusCode ?? 500,
        'data': e.data ?? 'Unknown error occurred',
      };
    } else {
      // Handle any other type of exception
      debugPrint('Error during joining kaksha: $e');
      return {
        'statusCode': 500,
        'data': 'Something went wrong. Please try again later.',
      };
    }
  }
}
