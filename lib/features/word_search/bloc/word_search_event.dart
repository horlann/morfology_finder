part of 'word_search_bloc.dart';

@immutable
sealed class WordSearchEvent {}

class WordSearchInitEvent extends WordSearchEvent {}

class WordSearchTextChangeEvent extends WordSearchEvent {
  WordSearchTextChangeEvent(
    this.query,
  );

  final String query;
}

class WordSearchSelectEvent extends WordSearchEvent {
  WordSearchSelectEvent(
    this.wordModel,
  );

  final WordModel wordModel;
}

// class SelectEvent extends WordSearchEvent {
//   SelectEvent();
// }

class WordSearchLoadMoreEvent
    extends WordSearchEvent {} // Новый Event для подгрузки
