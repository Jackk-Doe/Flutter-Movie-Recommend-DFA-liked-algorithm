import 'package:flutter/material.dart';
import 'package:movie_recommend_dfa/widgets/widgets.dart';

class ErrorPage extends StatelessWidget {
  final String errorMsg;
  final Function callBackFn;

  static MaterialPage page(String errorMessage, Function callBackFunction) {
    return MaterialPage(
      child: ErrorPage(
        errorMsg: errorMessage,
        callBackFn: callBackFunction,
      ),
    );
  }

  const ErrorPage({
    required this.errorMsg,
    required this.callBackFn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/error_img.png', fit: BoxFit.fill),
            const SizedBox(height: 20),

            Text(errorMsg, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 20),

            // Only show Button if [callBackFn] is not null
            CustomElevatedButton(
              buttonText: 'Back to Home Page',
              buttonColor: Colors.red,
              onPressfunc: () {
                // TODO : Back to Home Page
              },
            ),
          ],
        ),
      ),
    );
  }
}
