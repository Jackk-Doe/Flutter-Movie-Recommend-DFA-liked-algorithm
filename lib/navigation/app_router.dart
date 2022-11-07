import 'package:flutter/material.dart';
import 'package:movie_recommend_dfa/pages/movie_select_page.dart';

import '../providers/providers.dart';
import '../pages/pages.dart';

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

        /// Splash page
        if (appStateProvider.isValidateInternetConnection == false ||
            appStateProvider.isValidateTmdbApiKey == false)
          SplashPage.page(),

        /// Home page
        if (appStateProvider.beInHomePage) HomePage.page(),

        /// Genre Select Page
        if (!appStateProvider.beInHomePage && appStateProvider.beInGenreSelectPage) 
          GenreSelectPage.page(),

        /// Movie Select Page
        if (!appStateProvider.beInGenreSelectPage && appStateProvider.beInMovieSelectPage)
          MovieSelectpage.page(),

        /// Error page
        if (appStateProvider.hasError) ErrorPage.page(appStateProvider.errorMessage, () {
          // TODO : Implement Error button function
        }),
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
