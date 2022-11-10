import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';
import '../utils/utils.dart';

class MovieRecommendPage extends StatefulWidget {

  static MaterialPage page() {
    return const MaterialPage(child: MovieRecommendPage());
  }


  const MovieRecommendPage({super.key});

  @override
  State<MovieRecommendPage> createState() => _MovieRecommendPageState();
}

class _MovieRecommendPageState extends State<MovieRecommendPage> {

  late Future<List<Movie>> _movies;


  /// To load Movie List, based on previous selected datas,
  /// also filtering out previous selected Movie
  void _loadMovieList() async {
    //* Get user's interested genres & selected MovieIds record from provider
    var provider = Provider.of<MovieRecommendProvider>(context, listen: false);
    List<int> previousSelectedMovieIds = provider.recordedMovieIds;

    //* Generate random movies, based on user interested genre.Ids, filtering with previous selected Movie.Ids
    //* The ApiServices function is guranteed to get atleast 10 movies
    Map<int, int> interestedGenres = provider.interestedGenre;
    _movies = TmdbApiServices.getMoviesByGenreIDs(genreIdsAndCounts: interestedGenres, filterIds: previousSelectedMovieIds, movies: []);
  }


  @override
  void initState() {
    super.initState();
    _loadMovieList();
  }

  @override
  Widget build(BuildContext context) {
    List<String> genreDatas = 
        Provider.of<MovieRecommendProvider>(context, listen: false)
            .getUserInterestingGenreCount();
        
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// Page Title
            const Text(
              "Movie Recommend based on your selected choices",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),


            /// Selected Genre's title and counts
            Container(
              alignment: Alignment.center,
              height: 80,
              width: 350,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    const Text(
                      "Your Selected Genre' titles & counts :",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      genreDatas.join(",     "),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),


            /// Movies List
            Container(
              color: Colors.blue[100],
              height: 500,
              width: 350,
              child: FutureBuilder(
                future: _movies,
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
            const SizedBox(height: 10),


            /// Go Back Button
            CustomIconButton(
              buttonMessage: "Back to Home",
              buttonColor: Colors.cyan,
              buttonIcon: Icon(Icons.stop),
              buttonFnc: () {},
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
        return Container(
          color: Colors.blue[100],
          padding: const EdgeInsets.all(6),
          child: MovieGrid(
            title: movies[index].title,
            poster_path: movies[index].poster_path,
          ),
        );
      },
    );
  }
}