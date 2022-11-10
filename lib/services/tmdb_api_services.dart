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


  // /// Use this to get List of Movie, based bo given [genreIDs] arg
  // /// If success return data List, else return Empty List
  // static Future<List<Movie>> getMoviesByGenreIds(List<int> genreIDs, {int page = 1}) async {
  //   List<Movie> movies = [];

  //   // Convert List<int> to String
  //   String genreIDsStringConverted = genreIDs.join(",");

  //   try {
  //     http.Response res = await http.get(
  //       Uri.parse(
  //         "${Constants.BASE_URL}/discover/movie?${Constants.API_KEY_QUERY}&with_genres=$genreIDsStringConverted&page=$page"
  //       ),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8'
  //       },
  //     );

  //     if (res.statusCode == 200) {
  //       Map<String, dynamic> decoded = jsonDecode(res.body);
  //       List<dynamic> moviesMap = decoded["results"];
  //       List<Movie> movieModels = moviesMap.map((e) => Movie.fromMap(e)).toList();
  //       movies = movieModels;
  //     }
  //   } catch (e) {
  //     // NOTE : Not sure what to catch here
  //   }
    
  //   return movies;
  // }


  // /// Get a List of Movie, by given [genreIds], also filtering by Movie [filterIds]
  // static Future<List<Movie>> getMoviesByGenresAndFilterByIds(List<int> filterIds, List<int> genreIds) async {
  //   List<Movie> movies = await getMoviesByGenreIds(genreIds);
  //   movies.removeWhere((movie) {
  //     return filterIds.contains(movie.id);
  //   });

  //   return movies;
  // }


  /// Recursive function : get at least 10 movies, via given genre.Ids
  static Future<List<Movie>> getMoviesByGenreIDs({
    required Map<int, int> genreIdsAndCounts,       //Genre.Ids and count
    required List<Movie> movies,                  //Return movies
    List<int> filterIds = const [],                 //Filtering selected movie.ids
    int page = 1,                                   //Pagination
  }) async {
    
    // Convert List<int> to String
    String genreIDsStringConverted = genreIdsAndCounts.keys.join(",");

    try {
      http.Response res = await http.get(
        Uri.parse(
          "${Constants.BASE_URL}/discover/movie?${Constants.API_KEY_QUERY}&with_genres=$genreIDsStringConverted&page=$page"
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> decoded = jsonDecode(res.body);
        int availablePage = decoded["total_pages"];  //Total page
        List<dynamic> moviesMap = decoded["results"];
        List<Movie> movieModels = moviesMap.map((e) => Movie.fromMap(e)).toList();

        // Get List of Movie.id of current [movies] var
        List<int> alreadyExistedIds = [];
        movies.forEach((movie) {
          alreadyExistedIds.add(movie.id);
        });

        // Filtering the newly loaded Movies, only get un-selected movies, & movies that are not in [movies]
        movieModels.removeWhere((movie) {
          return filterIds.contains(movie.id) || alreadyExistedIds.contains(movie.id);
        });

        movies.addAll(movieModels);

        print("Current loaded TMDB Movies length is : ${movies.length}");

        // If API returned result (movies) are less than 10
        if (movies.length < 10) {

          // If still have available page
          if (availablePage > page) {
            movies = await getMoviesByGenreIDs(genreIdsAndCounts: genreIdsAndCounts, movies: movies, filterIds: filterIds, page: page++);
          } 
          // Else, cut out the least count of genre.Ids
          else {
            int leastCountId = genreIdsAndCounts.keys.first;

            // Get the least count
            genreIdsAndCounts.forEach((id, count) {
              if (id != leastCountId && count < genreIdsAndCounts[leastCountId]!) {
                leastCountId = id;
              }
            });

            // Create a new var [reduced] to prevent, var pass by ref problem in recursion
            Map<int, int> reduced = {};
            reduced.addAll(genreIdsAndCounts);
            
            // Remove the least count genre.id
            reduced.remove(leastCountId);

            movies = await getMoviesByGenreIDs(genreIdsAndCounts: reduced, movies: movies, filterIds: filterIds, page: page);
          }
        }
      }
    } catch (e) {
      // NOTE : Not sure what to catch here
    }
    
    return movies;
  }
}
