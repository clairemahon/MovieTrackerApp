import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minichallenge3/models/profile_manager.dart';
import 'package:minichallenge3/models/user_manager.dart';
import 'package:minichallenge3/screens/home_screen.dart';
import 'package:minichallenge3/screens/profile_screen.dart';
import 'package:minichallenge3/screens/user_screen.dart';
import 'package:minichallenge3/screens/search_screen.dart';
import '../models/app_state_manager.dart';

// AppRouter is a class that handles the routing of the app
// It uses the GoRouter package to handle routing
// It is used to navigate between the main pages of the app - trending movies,
// my profile and preferences, and search to find new movies

class AppRouter {
  final AppStateManager appStateManager;
  final ProfileManager profileManager;
  final UserManager userManager;

  AppRouter(
    this.appStateManager,
    this.profileManager,
    this.userManager,
  );

  late final router = GoRouter(
    debugLogDiagnostics: true, // set to false for production
    refreshListenable: appStateManager,
    initialLocation: '/trending',
    routes: [
      GoRoute(
          name: 'trending',
          path: '/:tab',
          builder: (context, state) {
            final tab = int.tryParse(state.pathParameters['tab'] ?? '') ?? 0;
            return MainScreen(key: state.pageKey, currentTab: tab);
          }),
      GoRoute(
          name: 'search',
          path: '/search/:id',
          builder: (context, state) {
            return SearchScreen();
          }),
      GoRoute(
          name: 'profile',
          path: '/profile',
          builder: (context, state) {
            final itemId = state.pathParameters['id'] ?? '';
            final item = profileManager.getSavedMovie(itemId);
            return SearchScreen(); // change to profile screen
          },
          routes: [
            GoRoute(
              name: 'user',
              path: 'user',
              builder: (context, state) {
                final tab =
                    int.tryParse(state.pathParameters['tab'] ?? '') ?? 0;
                return UserScreen(
                  user: userManager.getUser,
                  currentTab: tab,
                );
              },
            )
          ]),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
          key: state.pageKey,
          child: Scaffold(
              body: Center(
            child: Text(state.error.toString()),
          )));
    },
    redirect: (context, state) {
      return '/${CineScreenTab.trending}';
    },
  );
}
