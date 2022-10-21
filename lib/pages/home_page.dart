import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _startGetRecommendMovie() {
    // TODO : Go to Pick Movie type page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Page', style: TextStyle(fontSize: 44)),
            const SizedBox(height: 30),

            CustomElevatedButton(onPressfunc: _startGetRecommendMovie, buttonText: "START")
          ],
        ),
      ),
    );
  }
}