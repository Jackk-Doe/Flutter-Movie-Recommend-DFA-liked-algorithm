import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final _random = Random();

  // Test datas
  final genres = [
    "Action",
    "Adventure",
    "Animation",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Fantasy",
    "History",
    "Horror",
    "Music",
    "Mystery",
    "Reomance",
    "Science Fiction",
    "TV Movie",
    "Thriller",
    "War",
    "Western"
  ];

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
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    color: Colors
                            .primaries[_random.nextInt(Colors.primaries.length)]
                        [_random.nextInt(9) * 100],
                    child: Center(
                      child: Text(
                        genres[index],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
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
                    // TODO : go to next page
                    print("Select button clicked!");
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
