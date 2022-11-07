import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                future: TmdbApiServices.getMoviesByGenres([18, 35, 16, 14, 12]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data!.isEmpty) {
                      // TODO : go to Error page
                    }

                    List<Movie> movies = snapshot.data!;
                    return Text(movies[0].title);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            const SizedBox(height: 20),

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
}