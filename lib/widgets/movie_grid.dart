import 'package:flutter/material.dart';

import '../constants/constants.dart';

/// Create Movie Grid widget,
/// to be used with Movie-GridView
class MovieGrid extends StatefulWidget {

  final String title;
  final String poster_path;

  MovieGrid({
    required this.title,
    required this.poster_path,
    super.key,
  });

  @override
  State<MovieGrid> createState() => _MovieGridState();
}

class _MovieGridState extends State<MovieGrid> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    // TODO : change to InkWell
    return GestureDetector(
      onTap: () {
        setState(() {
          isClicked = !isClicked;
        });
        // TODO : implement system here
      },
      child: Container(
        color: (isClicked ? Colors.blue[900] : Colors.blue[100]),
        padding: const EdgeInsets.all(6),
        child: Stack(
          children: [
            Image.network(
              "${Constants.IMG_BASE_URL}/w780${widget.poster_path}",
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black.withOpacity(.3),
                width: 163,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
