import 'dart:io';
import 'package:flutter/material.dart';
import 'package:movie_recommend_dfa/services/tmdb_api_services.dart';

import '../providers/providers.dart';

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

  /// Use this function to check API_KEY validation, then update states
  void testApiKey() async {
    try {
      bool result = await TmdbApiServices.getConfiguration();

      if (result) {
        _validatedTmdbApiKey = true;
        _inHomePage = true;
      } else {
        _isError = true;
      }
    } catch (_) {
      _isError = true;
    }

    notifyListeners();
  }
}