// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [WordSearchScreen]
class WordSearchRoute extends PageRouteInfo<void> {
  const WordSearchRoute({List<PageRouteInfo>? children})
    : super(WordSearchRoute.name, initialChildren: children);

  static const String name = 'WordSearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WordSearchScreen();
    },
  );
}
