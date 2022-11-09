import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';
import '../utils/utils.dart';

class MovieSelectpage extends StatefulWidget {

  static MaterialPage page() {
    return const MaterialPage(child: MovieSelectpage());
  }

  const MovieSelectpage({super.key});

  @override
  State<MovieSelectpage> createState() => _MovieSelectpageState();
}

class _MovieSelectpageState extends State<MovieSelectpage> {

  late Future<List<Movie>> _moviesList;
  Movie? _selectedMovie;

  /// To reload Movie List, based on provider datas, also filtering some
  void _reloadMovieList() async {
    //* Get user's interested genres & selected MovieIds record from provider
    var provider = Provider.of<MovieRecommendProvider>(context, listen: false);
    List<int> interestedgenres = provider.interestedGenre.keys.toList(growable: false);
    List<int> recordedMovieIds = provider.recordedMovieIds;

    //* Generate random movies, based on above value, but filtering with selected MovieIds
    _moviesList = TmdbApiServices.getMoviesByGenresAndFilterByIds(recordedMovieIds, interestedgenres);
  }

  @override
  void initState() {
    super.initState();
    _reloadMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Page title
            const Text(
              "Select One Interesting Movie",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            /// Movie List
            Container(
              color: Colors.blue[100],
              height: 500,
              width: 350,
              child: FutureBuilder(
                future: _moviesList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data!.isEmpty) {
                      // TODO : go to Error page
                    }

                    List<Movie> movies = snapshot.data!;
                    return _movieListGridView(movies);
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
                    // TODO : Reset, and go back to Home Page
                    Provider.of<AppStateProvider>(context, listen: false).backToHome();
                  },
                ),

                /// Select Button
                CustomIconButton(
                  buttonMessage: "Select",
                  buttonColor: Colors.blue,
                  buttonIcon: const Icon(Icons.check),
                  buttonFnc: () {
                    if (_selectedMovie == null) {
                      Utils.showSnackBar(context, "Please select 1 Movie");
                    }

                    // Update provider values
                    var provider = Provider.of<MovieRecommendProvider>(context, listen: false);
                    provider.recordInterestGenreIdList(_selectedMovie!.genre_ids);
                    provider.recordSelectedMovieId(_selectedMovie!.id);

                    setState(() {
                      //* Re-load data : update list with new provider values
                      _reloadMovieList();
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  /// Create GridView of given Movie list
  Widget _movieListGridView(List<Movie> movies) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: .65
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              _selectedMovie = movies[index];
            });
          },
          child: Container(
            color: (_selectedMovie == movies[index] ? Colors.blue[900] : Colors.blue[100]),
            padding: const EdgeInsets.all(6),
            child: MovieGrid(
              title: movies[index].title,
              poster_path: movies[index].poster_path,
            ),
          ),
        );
      },
    );
  }
}