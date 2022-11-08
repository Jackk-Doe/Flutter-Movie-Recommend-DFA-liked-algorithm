import 'package:flutter/material.dart';

import '../models/models.dart';

/// Create Genre Grid widget,
/// to be used with GenreGridView widget
class GenreGrid extends StatelessWidget {
  final MovieGenre movieGenre;

  const GenreGrid({
    required this.movieGenre,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      color: Colors.grey,
      child: Center(
        child: Text(
          movieGenre.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}