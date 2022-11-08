import 'package:flutter/material.dart';
import 'package:movie_recommend_dfa/widgets/genre_grid_view.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class GenreSelectPage extends StatefulWidget {
  static MaterialPage page() {
    return const MaterialPage(child: GenreSelectPage());
  }

  const GenreSelectPage({super.key});

  @override
  State<GenreSelectPage> createState() => _GenreSelectPageState();
}

class _GenreSelectPageState extends State<GenreSelectPage> {
  MovieGenre? _selectedGenre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Page Title
            const Text(
              "Select Movie Genre",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            /// Genre list
            Container(
              color: Colors.blue[100],
              height: 500,
              width: 350,
              child: FutureBuilder(
                future: TmdbApiServices.getGenres(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data!.isEmpty) {
                      // TODO : Go to Error Page
                    }
                    List<MovieGenre> genres = snapshot.data!;
                    return GenreGridView(
                      currentSelectedGenre: _selectedGenre,
                      genres: genres,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            const SizedBox(height: 20),

            /// Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Cancel Button
                CustomIconButton(
                  buttonMessage: "Cancel",
                  buttonColor: Colors.red,
                  buttonIcon: const Icon(Icons.cancel),
                  buttonFnc: () {
                    //* Reset and go back to Home page
                    Provider.of<AppStateProvider>(context, listen: false).backToHome();
                  },
                ),

                /// Select Button
                CustomIconButton(
                  buttonMessage: "Select",
                  buttonColor: Colors.blue,
                  buttonIcon: const Icon(Icons.check),
                  buttonFnc: () {
                    Provider.of<AppStateProvider>(context, listen: false).startMovieSelect();
                    // TODO : update value when user selected Genre
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  /// To create Grid View of given Genre list
  // Widget _genreListGridViewWidget(List<MovieGenre> genres) {
  //   return GridView.builder(
  //     padding: const EdgeInsets.all(8.0),
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //       mainAxisSpacing: 6,
  //       crossAxisSpacing: 6,
  //     ),
  //     itemCount: genres.length,
  //     itemBuilder: (context, index) {
  //       // Outer Container Box
  //       return GenreGrid(
  //         movieGenre: genres[index],
  //         onClick: () {
  //           print("Before: ${_selectedGenre?.name}");
  //           _selectedGenre = genres[index];
  //           print("After: ${_selectedGenre?.name}");
  //         },
  //       );
  //     },
  //   );
  // }
}
