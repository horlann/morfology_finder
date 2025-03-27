import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_web_worker_example/core/db/db.dart';
import 'package:flutter_web_worker_example/features/home/view/home_screen.dart';
import 'package:flutter_web_worker_example/features/introduce/view/introduce_screen.dart';
import 'package:flutter_web_worker_example/features/main/view/main_screen.dart';
import 'package:flutter_web_worker_example/features/spreadsheet/view/spreadsheet_screen.dart';
import 'package:flutter_web_worker_example/features/word_details/view/word_details_screen.dart';
import 'package:flutter_web_worker_example/features/word_search/data/models/word.dart';
import 'package:flutter_web_worker_example/features/word_search/view/word_search_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        page: IntroduceRoute.page,
        path: '/',
      ),
      AutoRoute(
        page: HomeRoute.page,
        path: '/main',
        // children: [
        //   AutoRoute(
        //     page: MainRoute.page,
        //     path: 'main',
        //   ),
        //   AutoRoute(
        //     page: WordSearchRoute.page,
        //     path: 'word_search',
        //   ),
        //   AutoRoute(
        //     page: SpreadsheetRoute.page,
        //     path: 'spreadsheet',
        //   ),
        // ]
      ),
      AutoRoute(
        page: WordDetailsRoute.page,
        path: '/word_details',
      ),
      AutoRoute(
        page: SpreadsheetRoute.page,
        path: '/spreadsheet',
      ),
    ];
  }
}
