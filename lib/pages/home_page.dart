import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {

  static MaterialPage page() {
    return const MaterialPage(child: HomePage());
  }

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          /// Upper sections
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Movie Recommend App',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                
                const Text(
                  'with DFA liked algorithm',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),

                const Icon(Icons.movie_filter_outlined, size: 72,),
                const SizedBox(height: 40),
                
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


          /// Lower sections
          Column(
            children: [
              const Text("Power by TMDB API", style: TextStyle(fontWeight: FontWeight.w500),),
              const SizedBox(height: 10),

              SizedBox(
                width: 100,
                height: 100,
                child: SvgPicture.asset(
                  "assets/tmdb_logo.svg"
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
