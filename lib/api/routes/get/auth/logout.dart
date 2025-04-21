import 'package:flutter/material.dart';
import 'package:gradegenius/api/api_service.dart';
import 'package:gradegenius/utils/constants.dart';

Future<Map<String, dynamic>> logout() async {
  try {
    final apiService = ApiService(Constants.secureStorage);
    final response = await apiService.getRequest('/auth/logout');

    if (response.statusCode == 200) {
      await Constants.secureStorage.delete(key: 'jwt');
      return response.data;
    } else {
      throw Exception('Failed to logout: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error during logout: $e');
    rethrow;
  }
}
