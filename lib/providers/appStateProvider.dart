import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  bool _validatedInternetConnection = false;
  bool _validatedTmdbApiKey = false;

  bool _inHomePage = false;

  bool get isValidateInternetConnection => _validatedInternetConnection;
  bool get isValidateTmdbApiKey => _validatedTmdbApiKey;
  bool get beInHomePage => _inHomePage;

  void testInternetConnection() {
    // TODO : test internet connection

    Future.delayed(const Duration(milliseconds: 2000), () {
      _validatedInternetConnection = true;
      print("Internet check : clear");
      notifyListeners();
    });

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