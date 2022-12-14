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
    List<int> previousSelectedMovieIds = provider.recordedMovieIds;


    //* (Old ver) Generate random movies, based on above value, but filtering with selected MovieIds
    // List<int> interestedgenres = provider.interestedGenre.keys.toList(growable: false);
    // _moviesList = TmdbApiServices.getMoviesByGenresAndFilterByIds(previousSelectedMovieIds, interestedgenres);


    //* Generate random movies, based on user interested genre.Ids, filtering with previous selected Movie.Ids
    //* The ApiServices function is guranteed to get atleast 10 movies
    Map<int, int> interestedGenres = provider.interestedGenre;
    _moviesList = TmdbApiServices.getMoviesByGenreIDs(genreIdsAndCounts: interestedGenres, filterIds: previousSelectedMovieIds, movies: []);
  }

  @override
  void initState() {
    super.initState();
    _reloadMovieList();
  }

  @override
  Widget build(BuildContext context) {
    List<String> userInterests = 
        Provider.of<MovieRecommendProvider>(context, listen: false)
            .getUserInterestingGenreCount();
    
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


            /// Show current User's selected genre counts
            Container(
              height: 80,
              width: 350,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "User Interested Genre title and count :",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      userInterests.join(",     "),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
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
                (Provider.of<MovieRecommendProvider>(context, listen: false)
                        .recordedMovieIds
                        .isEmpty
                    ?

                    /// Cancel Button : has not selected any movie yet
                    CustomIconButton(
                        buttonMessage: "Cancel",
                        buttonColor: Colors.red,
                        buttonIcon: const Icon(Icons.cancel),
                        buttonFnc: () {
                          //* Reset all values in Movie-Recom provider
                          Provider.of<MovieRecommendProvider>(context, listen: false)
                              .resetAllValues();

                          //* Notify App-State provider, back to Home
                          Provider.of<AppStateProvider>(context, listen: false)
                              .backToHome();
                        },
                      )
                    :

                    /// Stop Button : stop getting new random movies
                    CustomIconButton(
                        buttonMessage: "Stop",
                        buttonColor: Colors.cyan,
                        buttonIcon: const Icon(Icons.stop),
                        buttonFnc: () {
                          // Stop generate new Random movie
                          Provider.of<AppStateProvider>(context, listen: false)
                              .startMovieRecom();
                        },
                      )),

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

                    // NOTE : print User's selected Genres ID & counts
                    // print("Interested : ${provider.interestedGenre}");

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