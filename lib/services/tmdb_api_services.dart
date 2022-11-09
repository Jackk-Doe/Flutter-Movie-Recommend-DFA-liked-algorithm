import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/models.dart';
import '../constants/constants.dart';

class TmdbApiServices {

  /// Use this to check API Key availability,
  /// If success return True, else False
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


  /// Use this to get List of Genre,
  /// If success return data List, else return Empty List
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


  /// Use this to get List of Movie, based bo given [genreIDs] arg
  /// If success return data List, else return Empty List
  static Future<List<Movie>> getMoviesByGenreIds(List<int> genreIDs) async {
    List<Movie> movies = [];

    // Convert List<int> to String
    String genreIDsStringConverted = genreIDs.join(",");

    try {
      http.Response res = await http.get(
        Uri.parse(
          "${Constants.BASE_URL}/discover/movie?${Constants.API_KEY_QUERY}&with_genres=$genreIDsStringConverted"
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> decoded = jsonDecode(res.body);
        List<dynamic> moviesMap = decoded["results"];
        List<Movie> movieModels = moviesMap.map((e) => Movie.fromMap(e)).toList();
        movies = movieModels;
      }
    } catch (e) {
      // NOTE : Not sure what to catch here
    }
    
    return movies;
  }


  /// Get a List of Movie, by given [genreIds], also filtering by Movie [filterIds]
  static Future<List<Movie>> getMoviesByGenresAndFilterByIds(List<int> filterIds, List<int> genreIds) async {
    List<Movie> movies = await getMoviesByGenreIds(genreIds);
    movies.removeWhere((movie) {
      return filterIds.contains(movie.id);
    });

    return movies;
  }
}
