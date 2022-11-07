import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigation/app_router.dart';
import 'providers/providers.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /*
  Providers 
  */
  final _appStateProvider = AppStateProvider();

  /*
  Navigator 2.0 : App router
  */
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateProvider: _appStateProvider,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _appStateProvider,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Router(
          routerDelegate: _appRouter,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
