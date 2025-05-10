import 'dart:ui';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Constants {
  // Existing constants
  static const String appName = 'Grade Genius';
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  static const String loader = 'assets/images/loading.gif';
  static const Color darkThemeBg = Color.fromARGB(255, 14, 14, 14);
  static const Color darkThemeFontColor = Color.fromARGB(255, 255, 255, 255);
  static const String backendUrl = 'https://gradegenius-backend.onrender.com';
  
  // Colors
  static const Color primaryColor = Color(0xFFA7C7E0);  // Light blue used for headers and buttons
  static const Color secondaryTextColor = Color.fromARGB(255, 158, 158, 158);  // Grey for secondary text
  static const Color inputBgColor = Color.fromARGB(13, 255, 255, 255);  // Semi-transparent white for input fields
  static const Color dividerColor = Color.fromARGB(61, 255, 255, 255);  // Semi-transparent white for dividers
  static const Color errorColor = Color.fromARGB(255, 244, 67, 54);  // Red for error messages
  static const Color successColor = Color.fromARGB(255, 76, 175, 80);  // Green for success messages
  
  // Styling
  static const double defaultBorderRadius = 10.0;
  static const double buttonBorderRadius = 50.0;
  static const double defaultPadding = 16.0;
  static const double sectionPadding = 24.0;
  static const double defaultSpacing = 15.0;
  static const double largePadding = 30.0;
  
  // Font sizes
  static const double headingFontSize = 18.0;
  static const double bodyFontSize = 16.0;
  static const double labelFontSize = 14.0;
  static const double smallFontSize = 12.0;
  static const double largeFontSize = 20.0;
  static const double initialsTextSize = 40.0;
  
  // Other dimensions
  static const double avatarSize = 120.0;
  static const double avatarBadgeSize = 34.0;  // Size of the camera icon container
  static const double formInputHeight = 50.0;
  
  // Form validation
  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phoneRegex = r'^\d{10}$';
  
  // Font family
  static const String fontFamily = 'GoogleSans';
  
  // Date formatting
  static const String dateFormat = 'dd/MM/yyyy';
  
  // Image assets
  static const String defaultAvatarImage = 'assets/images/avatar.png';
}