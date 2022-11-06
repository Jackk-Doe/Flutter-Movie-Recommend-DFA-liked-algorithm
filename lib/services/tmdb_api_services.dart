import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/models.dart';
import '../constants/constants.dart';

class TmdbApiServices {

  /// Use this to check API Key availability
  static Future<bool> getConfiguration() async {
    try {
      http.Response res = await http.get(
        Uri.parse(
            "${Constants.BASE_URL}/configuration?${Constants.API_KEY_QUERY}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (res.statusCode != 200) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }


  /// Use this to get List of Genre
  static Future<List<MovieGenre>> getGenres() async {
    List<MovieGenre> genres = [];

    try {
      http.Response res = await http.get(
        Uri.parse(
          "${Constants.BASE_URL}/genre/movie/list?${Constants.API_KEY_QUERY}"
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> decoded = jsonDecode(res.body);
        List<dynamic> genresMap = decoded["genres"];
        List<MovieGenre> genreModels = genresMap.map((e) => MovieGenre.fromMap(e)).toList();
        genres = genreModels;
      }
    } catch (e) {
      // NOTE : Not sure what to catch here
    }
    return genres;
  }
}
