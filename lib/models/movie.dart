import 'dart:convert';

/// To store Movie data into model class
class Movie {
  final int id;
  final List<int> genre_ids;
  final String title;
  final String release_date;
  final String original_title;
  final String overview;
  final String poster_path;
  final double vote_average;

  Movie({
    required this.id,
    required this.genre_ids,
    required this.title,
    required this.release_date,
    required this.original_title,
    required this.overview,
    required this.poster_path,
    required this.vote_average,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'genre_ids': genre_ids});
    result.addAll({'title': title});
    result.addAll({'release_date': release_date});
    result.addAll({'original_title': original_title});
    result.addAll({'overview': overview});
    result.addAll({'poster_path': poster_path});
    result.addAll({'vote_average': vote_average});
  
    return result;
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id']?.toInt() ?? 0,
      genre_ids: List<int>.from(map['genre_ids']),
      title: map['title'] ?? '',
      release_date: map['release_date'] ?? '',
      original_title: map['original_title'] ?? '',
      overview: map['overview'] ?? '',
      poster_path: map['poster_path'] ?? '',
      vote_average: map['vote_average']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}
