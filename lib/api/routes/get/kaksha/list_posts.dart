import 'package:flutter/material.dart';
import 'package:gradegenius/api/api_service.dart';
import 'package:gradegenius/utils/constants.dart';

Future<Map<String, dynamic>> allKakshaPosts(String kakshaId) async {
  try {
    final apiService = ApiService(Constants.secureStorage,authRequired: true);
    final response = await apiService.getRequest('/kaksha/kaksha-posts?kaksha_id=$kakshaId');

    if (response.statusCode == 200) {
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } else {
      throw Exception('Failed to fetch kaksha posts: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error during fetching kaksha posts: $e');
    rethrow;
  }
}
