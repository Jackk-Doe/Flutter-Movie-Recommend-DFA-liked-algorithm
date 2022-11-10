import 'package:flutter/material.dart';
import 'package:movie_recommend_dfa/widgets/genre_grid_view.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';
import '../utils/utils.dart';

// NOTE : should have call [TmdbApiServices.getGenres()] in initState(),
//        or somewhere else, but not in build()

// NOTE 2 : selecting system in MovieSelectPage is better implemented

// NOTE 3 : lazy to change
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

  late Future<List<MovieGenre>> _genreList;

  @override
  void initState() {
    super.initState();
    _genreList = TmdbApiServices.getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Page Title
            const Text(
              "Select One Movie Genre",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            /// Genre list
            Container(
              color: Colors.blue[100],
              height: 500,
              width: 350,
              child: FutureBuilder(
                future: _genreList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data!.isEmpty) {
                      // TODO : Go to Error Page
                    }

                    List<MovieGenre> genres = snapshot.data!;

                    //* Set TMDB genres datas into Movie-Recom provider
                    Provider.of<MovieRecommendProvider>(context, listen: false).setGenres(genres);

                    return GenreGridView(
                      currentSelectedGenre: _selectedGenre,
                      genres: genres,
                      onClick: (newSelectGenre) {
                        if (_selectedGenre == null ||
                            (_selectedGenre != null &&
                                _selectedGenre != newSelectGenre)) {
                          //* If [_selectedGenre] is not null, or [newSelectGenre] is different,
                          //* re-assign [_selectedGenre]
                          _selectedGenre = newSelectGenre;
                        }
                        return _selectedGenre;
                      },
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
                    Provider.of<AppStateProvider>(context, listen: false)
                        .backToHome();
                  },
                ),

                /// Select Button
                CustomIconButton(
                  buttonMessage: "Select",
                  buttonColor: Colors.blue,
                  buttonIcon: const Icon(Icons.check),
                  buttonFnc: () {
                    if (_selectedGenre == null) {
                      Utils.showSnackBar(
                          context, "Please select 1 Genre first");
                      return;
                    }

                    //* Update selected movie genre via Movie-Recom provider
                    Provider.of<MovieRecommendProvider>(context, listen: false)
                        .recordInterestGenreId(_selectedGenre!.id);

                    //* Notify App-State provider
                    Provider.of<AppStateProvider>(context, listen: false)
                        .startMovieSelect();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
