import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {

  static MaterialPage page() {
    return const MaterialPage(child: HomePage());
  }

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Page', style: TextStyle(fontSize: 44)),
            const SizedBox(height: 30),
            
            CustomElevatedButton(
              onPressfunc: () {
                Provider.of<AppStateProvider>(context, listen: false).startGenreSelect();
              },
              buttonText: "START",
              buttonColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
