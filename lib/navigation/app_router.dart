import 'package:flutter/material.dart';

import 'package:movie_recommend_dfa/providers/providers.dart';
import 'package:movie_recommend_dfa/pages/pages.dart';

class AppRouter extends RouterDelegate with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  /// To accesses unique key across the entire app
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateProvider appStateProvider;

  AppRouter({
    required this.appStateProvider,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    /// When the state changed, router will re-configure the navigator with new set of pages
    appStateProvider.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateProvider.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (appStateProvider.isValidateInternetConnection == false ||
            appStateProvider.isValidateTmdbApiKey == false)
          SplashPage.page(),

        if (appStateProvider.beInHomePage) HomePage.page(),
      ],
    );
  }

  // TODO : Configure this later
  bool _handlePopPage(Route<dynamic> route, result) {
    return true;
  }

  /// Since not supporting Flutter web apps yet, set to null
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
