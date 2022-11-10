import 'dart:convert';

/// To store Movie Genre data into model class
class MovieGenre {
  final String name;
  final int id;

  MovieGenre({
    required this.name,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'id': id});
  
    return result;
  }

  factory MovieGenre.fromMap(Map<String, dynamic> map) {
    return MovieGenre(
      name: map['name'] ?? '',
      id: map['id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieGenre.fromJson(String source) => MovieGenre.fromMap(json.decode(source));
}
