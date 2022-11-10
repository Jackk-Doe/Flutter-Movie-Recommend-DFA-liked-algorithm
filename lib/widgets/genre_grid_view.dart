import 'package:flutter/material.dart';

import '../models/models.dart';
import 'genre_grid.dart';


/// Create Genre Grid-View from given MovieGenre list
class GenreGridView extends StatefulWidget {
  final List<MovieGenre> genres;
  MovieGenre? currentSelectedGenre;

  /// [onClick] : select & return new genre, or keep a current genre
  final MovieGenre? Function(MovieGenre) onClick;

  GenreGridView({
    required this.genres,
    required this.onClick,
    required this.currentSelectedGenre,
    Key? key,
  }) : super(key: key);

  @override
  State<GenreGridView> createState() => _GenreGridViewState();
}

class _GenreGridViewState extends State<GenreGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      itemCount: widget.genres.length,
      itemBuilder: (context, index) {
        // Outer Container Box
        return InkWell(
          onTap: () {
            widget.currentSelectedGenre = widget.onClick(widget.genres[index]);
            setState(() {});
          },
          child: Container(
            color: (widget.currentSelectedGenre == widget.genres[index]
                ? Colors.blue[900]
                : Colors.grey),
            child: GenreGrid(movieGenre: widget.genres[index]),
          ),
        );
      },
    );
  }
}
