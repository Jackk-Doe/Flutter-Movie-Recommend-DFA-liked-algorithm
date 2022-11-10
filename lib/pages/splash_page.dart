import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';


class SplashPage extends StatefulWidget {

  static MaterialPage page() {
    return const MaterialPage(child: SplashPage());
  }

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AppStateProvider>(context, listen: false).testInternetConnection();
    Provider.of<AppStateProvider>(context, listen: false).testApiKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Starting the app",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400
              ),
            ),
            SizedBox(height: 20),

            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}