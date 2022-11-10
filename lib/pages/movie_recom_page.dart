import 'package:flutter/material.dart';

class MovieRecommendPage extends StatelessWidget {

  static MaterialPage page() {
    return const MaterialPage(child: MovieRecommendPage());
  }

  const MovieRecommendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("Movie Recommend Page"),),
    );
  }
}