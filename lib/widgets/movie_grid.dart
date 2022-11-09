import 'package:flutter/material.dart';

import '../constants/constants.dart';

/// Create Movie Grid widget,
/// to be used with Movie-GridView
class MovieGrid extends StatelessWidget {

  final String title;
  final String poster_path;

  const MovieGrid({
    required this.title,
    required this.poster_path,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        /// Movie Image
        Image.network(
          "${Constants.IMG_BASE_URL}/w780$poster_path",
          fit: BoxFit.fill,
          loadingBuilder: (context, child, loadingProgress) {

            if (loadingProgress == null) {
              //* Image Loading : Successed
              return child;
            }

            //* Image Loading : Inprogress
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            //* Image Loading : Fail
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Loading Image Failed"),
                  Icon(Icons.error)
                ],
              ),
            );
          },
        ),

        /// Movie Title
        Positioned(
          bottom: 0,
          child: Container(
            color: Colors.black.withOpacity(.3),
            width: 163,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white
              ),
            ),
          ),
        ),
      ],
    );
  }
}
