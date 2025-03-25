
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:morphology_finder/features/home/view/home_screen.dart';
import 'package:morphology_finder/features/word_details/view/word_details_screen.dart';
import 'package:morphology_finder/features/word_search/view/word_search_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        page: HomeRoute.page,
        path: '/',
      ),
      AutoRoute(
        page: WordSearchRoute.page,
        path: '/word_search',
      ),
      AutoRoute(
        page: WordDetailsRoute.page,
        path: '/word_details',
      ),
    ];
  }
}
