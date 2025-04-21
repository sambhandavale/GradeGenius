import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

void showToast({
  required String message,
  bool isError = false,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: isError ? Colors.red : Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}