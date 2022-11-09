import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

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

  @override
  void initState() {
    super.initState();
    _moviesList = TmdbApiServices.getMoviesByGenres([18, 35, 16, 14, 12]);
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
                // TODO : call API some where else! would make life easier
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

                /// Cancel Button
                CustomIconButton(
                  buttonMessage: "Select",
                  buttonColor: Colors.blue,
                  buttonIcon: const Icon(Icons.check),
                  buttonFnc: () {
                    // TODO : Update value user interest
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
        return MovieGrid(
          title: movies[index].title,
          poster_path: movies[index].poster_path,
        );
      },
    );
  }
}