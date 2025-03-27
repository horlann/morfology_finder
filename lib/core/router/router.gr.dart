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
/// [IntroduceScreen]
class IntroduceRoute extends PageRouteInfo<void> {
  const IntroduceRoute({List<PageRouteInfo>? children})
    : super(IntroduceRoute.name, initialChildren: children);

  static const String name = 'IntroduceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const IntroduceScreen();
    },
  );
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}

/// generated route for
/// [SpreadsheetScreen]
class SpreadsheetRoute extends PageRouteInfo<void> {
  const SpreadsheetRoute({List<PageRouteInfo>? children})
    : super(SpreadsheetRoute.name, initialChildren: children);

  static const String name = 'SpreadsheetRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SpreadsheetScreen();
    },
  );
}

/// generated route for
/// [WordDetailsScreen]
class WordDetailsRoute extends PageRouteInfo<WordDetailsRouteArgs> {
  WordDetailsRoute({
    Key? key,
    required String word,
    List<PageRouteInfo>? children,
  }) : super(
         WordDetailsRoute.name,
         args: WordDetailsRouteArgs(key: key, word: word),
         initialChildren: children,
       );

  static const String name = 'WordDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WordDetailsRouteArgs>();
      return WordDetailsScreen(key: args.key, word: args.word);
    },
  );
}

class WordDetailsRouteArgs {
  const WordDetailsRouteArgs({this.key, required this.word});

  final Key? key;

  final String word;

  @override
  String toString() {
    return 'WordDetailsRouteArgs{key: $key, word: $word}';
  }
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
