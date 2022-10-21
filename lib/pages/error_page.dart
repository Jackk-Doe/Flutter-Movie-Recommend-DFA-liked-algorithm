import 'package:flutter/material.dart';
import 'package:movie_recommend_dfa/widgets/widgets.dart';

class ErrorPage extends StatelessWidget {
  final String errorMsg;

  const ErrorPage({
    this.errorMsg = "Error Found!", 
    super.key
  });

  void _goToHomePage() {
    // TODO : Go back to Home Page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/error_img.png', fit: BoxFit.fill),
            const SizedBox(height: 20),

            Text(errorMsg, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 20),

            CustomElevatedButton(
              onPressfunc: _goToHomePage,
              buttonText: 'Back to Home Page',
              buttonColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
