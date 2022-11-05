import 'dart:io';
import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  bool _validatedInternetConnection = false;
  bool _validatedTmdbApiKey = false;

  bool _inHomePage = false;
  bool _isError = false;

  bool get isValidateInternetConnection => _validatedInternetConnection;
  bool get isValidateTmdbApiKey => _validatedTmdbApiKey;
  bool get beInHomePage => _inHomePage;


  /// Use this function to check Internet connection, then update states
  void testInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _validatedInternetConnection = true;
      } else {
        _isError = true;
      }
    } catch (_) {
      _isError = true;
    }

    notifyListeners();
  }

  void testApiKey() {
    // TODO : test api key available


    Future.delayed(const Duration(milliseconds: 3000), () {
      _validatedTmdbApiKey = true;
      print("API Key check : clear");
      _inHomePage = true;
      notifyListeners();
    });

  }
}