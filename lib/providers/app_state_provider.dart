import 'dart:io';

import 'package:flutter/material.dart';

import '../services/tmdb_api_services.dart';


class AppStateProvider extends ChangeNotifier {
  /*
  Provider values
  */
  bool _validatedInternetConnection = false;
  bool _validatedTmdbApiKey = false;

  bool _inHomePage = false;
  bool _isGenreSelectPage = false;
  bool _isError = false;

  String _errorMessageDefault = "Unknown Error founds";
  String _errorMessage = "Unknown Error founds";

  /*
  Provider getters
  */
  bool get isValidateInternetConnection => _validatedInternetConnection;
  bool get isValidateTmdbApiKey => _validatedTmdbApiKey;
  bool get beInHomePage => _inHomePage;
  bool get beInGenreSelectPage => _isGenreSelectPage;
  bool get hasError => _isError;

  String get errorMessage => _errorMessage;


  /// Use this function to check Internet connection, then update states
  void testInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _validatedInternetConnection = true;
      } else {
        _isError = true;
        _errorMessage = "Error : No Internet connection";
      }
    } catch (_) {
      _isError = true;
      _errorMessage = "Error : Problem with Internet connection";
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
        _errorMessage = "Error : TMDB API key problem found";
      }
    } catch (_) {
      _isError = true;
      _errorMessage = "Error : Problem with API key validation process";
    }

    notifyListeners();
  }

  /// Use this to go from HomePage to GenreSelectPage
  void startGenreSelect() {
    _inHomePage = false;
    _isGenreSelectPage = true;
    notifyListeners();
  }

  /// Use this to reset, and go back to Home Page
  void backToHome() {
    _isGenreSelectPage = false;
    // TODO : reset other later values

    _inHomePage = true;
    notifyListeners();
  }
}