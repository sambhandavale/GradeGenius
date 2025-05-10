import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;

  AuthInterceptor(this._storage);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await _storage.read(key: 'jwt');
    if (token != null && !JwtDecoder.isExpired(token)) {
      options.headers['authorization'] = 'Bearer $token';
    } else if (token != null && JwtDecoder.isExpired(token)) {
      await _storage.delete(key: 'jwt');
      debugPrint('Token refresh failed');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await _storage.delete(key: 'jwt');
      debugPrint('Token refresh failed');
    }

    handler.next(err);
  }
}