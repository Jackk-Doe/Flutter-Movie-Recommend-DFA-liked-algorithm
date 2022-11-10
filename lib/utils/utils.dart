import 'package:flutter/material.dart';

class Utils {

  /// Utils function to show Snack-Bar message in Scaffold
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}