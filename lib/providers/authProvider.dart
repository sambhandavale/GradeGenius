import 'package:flutter/material.dart';
import 'package:gradegenius/api/routes/get/user/user_details.dart';
import 'package:gradegenius/models/users.dart';
import 'package:gradegenius/utils/constants.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

class AuthProvider with ChangeNotifier {
  static const _storage = Constants.secureStorage;
  bool _isAuthenticated = false;

  User? _user;

  bool get isAuthenticated => _isAuthenticated;

  User? get user => _user;

  Future<void> login(String token) async {
    try {
      await _storage.write(key: 'jwt', value: token);
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving token: $e');
    }
  }

  Future<void> fetchUser() async {
    try {
      final value = await getUser();
      if (value['statusCode'] == 200) {
        _user = User.fromJson(value['data']['user']);
      }
    } catch (e) {
      debugPrint('Error getting user: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _storage.delete(key: 'jwt');
      _isAuthenticated = false;

      await checkLoginStatus();

      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting token: $e');
    }
  }

  Future<void> checkLoginStatus() async {
    try {
      _isAuthenticated = await _isLoggedIn();
      if (!_isAuthenticated) {
        _user = null;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error checking login status: $e');
    }
  }

  Future<bool> _isLoggedIn() async {
    try {
      String? jwt = await _storage.read(key: 'jwt');
      if (jwt == null) {
        return false;
      }
      return !JwtDecoder.isExpired(jwt);
    } catch (e) {
      debugPrint('Error reading token: $e');
      return false;
    }
  }
}
