import 'package:flutter/material.dart';

import '../models/models.dart';


/// This provider is to keep record of user's interested Movie genre
class MovieRecommendProvider extends ChangeNotifier {

  /// [_interested] <GenreID, count> : records user's interested genre
  Map<int, int> _interested = {};

  /// To record selected movie id into a list
  Set<int> _recordedMovieIds = {};

  /// Available genres titles & Ids from TMDB
  List<MovieGenre> _genres = [];


  Map<int, int> get interestedGenre => _interested;
  List<int> get recordedMovieIds => _recordedMovieIds.toList(growable: false);


  /// Get [_genres] data in Map
  Map<int, String> _getGenresMap() {
    Map<int, String> genres = {};
    _genres.forEach((genre) {
      genres[genre.id] = genre.name;
    });
    return genres;
  }

  /// Set [_genres] data
  void setGenres(List<MovieGenre> genres) {
    _genres = genres;
  }

  /// Create List<String> from [_interested]. e.g ["Action: 1", "Crime: 5"]
  List<String> getUserInterestingGenreCount () {
    List<String> result = [];
    Map<int, String> genres = _getGenresMap();
    _interested.forEach((id, count) {
      result.add("${genres[id]} : $count");
    });

    return result;
  }

  /// Record selected genreId into [_interested] map value
  void recordInterestGenreId(int genreId) {
    int currentCount = _interested.putIfAbsent(genreId, () => 0);
    _interested[genreId] = currentCount + 1;
  }

  /// Record selected Movie's genre.ids into [_interested] map value
  void recordInterestGenreIdList(List<int> idList) {
    idList.forEach(recordInterestGenreId);
  }

  /// Record selected Movie.id into [_recordedMovieIds] map value
  void recordSelectedMovieId(int movieId) {
    _recordedMovieIds.add(movieId);
  }
}
