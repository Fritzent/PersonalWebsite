import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/pages/starter_page.dart';
import 'package:personal_website/routes/app_routes_constants.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: '/started_page',
    routes: [
      GoRoute(
        path: '/started_page',
        name: GeneralRouteConstant.startedPageRouteName,
        pageBuilder: (context, state) {
          return MaterialPage(child: StarterPage());
        },
      ),
    ],
  );

  static GoRouter get router => _router;
}
