import 'package:flutter/material.dart';
import 'package:gradegenius/api/api_service.dart';
import 'package:gradegenius/utils/constants.dart';

Future<Map<String, dynamic>> deleteKaksha(String kakshaId) async {
  try {
    final apiService = ApiService(Constants.secureStorage,authRequired: true);
    final response = await apiService.deleteRequest('/kaksha/delete-kaksha?kakshaId=$kakshaId');

    if (response.statusCode == 200) {
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } else {
      throw Exception('Failed to delete kaksha: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error during deleting kaksha: $e');
    rethrow;
  }
}
