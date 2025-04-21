import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gradegenius/api/api_exception.dart';
import 'package:gradegenius/api/auth_interceptor.dart';

class ApiService {
  late Dio _dio;
  final FlutterSecureStorage _storage;
  late String _baseUrl;

  String _getBaseUrl() {
    if (kReleaseMode) {
      return 'https://gradegenius-backend.onrender.com/api';
    } else {
      if (Platform.isAndroid) {
        return 'https://gradegenius-backend.onrender.com/api';
      } else if (Platform.isIOS) {
        return 'https://gradegenius-backend.onrender.com/api';
      } else {
        throw UnsupportedError('Unsupported platform');
      }
    }
  }

  ApiService(this._storage, {bool authRequired = true}) {
    _dio = Dio();
    _baseUrl = _getBaseUrl();

    if (authRequired) {
      _dio.interceptors.add(AuthInterceptor(_storage));
    }
  }

  Future<Response> getRequest(String route) async {
    try {
      final url = '$_baseUrl$route';
      return await _dio.get(url);
    } catch (e) {
      if (e is DioException) {
        throw ApiException(e.response?.statusCode, e.response?.data);
      }
      rethrow;
    }
  }

  Future<Response> getFileRequest(String route) async {
    try {
      final url = '$_baseUrl$route';
      return await _dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
    } catch (e) {
      if (e is DioException) {
        throw ApiException(e.response?.statusCode, e.response?.data);
      }
      rethrow;
    }
  }


  Future<Response> postRequest(String route, dynamic data) async {
    try {
      final url = '$_baseUrl$route';
      return await _dio.post(url, data: data);
    } catch (e) {
      if (e is DioException) {
        throw ApiException(e.response?.statusCode, e.response?.data);
      }
      rethrow;
    }
  }

  Future<Response> putRequest(String route, dynamic data) async {
    try {
      final url = '$_baseUrl$route';
      return await _dio.put(url, data: data);
    } catch (e) {
      if (e is DioException) {
        throw ApiException(e.response?.statusCode, e.response?.data);
      }
      rethrow;
    }
  }

  Future<Response> deleteRequest(String route) async {
    try {
      final url = '$_baseUrl$route';
      return await _dio.delete(url);
    } catch (e) {
      if (e is DioException) {
        throw ApiException(e.response?.statusCode, e.response?.data);
      }
      rethrow;
    }
  }

  Future<Response> patchRequest(String route, dynamic data) async {
    try {
      final url = '$_baseUrl$route';
      return await _dio.patch(url, data: data);
    } catch (e) {
      if (e is DioException) {
        throw ApiException(e.response?.statusCode, e.response?.data);
      }
      rethrow;
    }
  }
}
