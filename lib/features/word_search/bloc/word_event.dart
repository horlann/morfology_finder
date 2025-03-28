part of 'word_bloc.dart';

@immutable
sealed class WordEvent {}

class WordInitEvent extends WordEvent {}

class WordTextChangeEvent extends WordEvent {
  WordTextChangeEvent(
    this.query,
  );

  final String query;
}

class WordSelectEvent extends WordEvent {
  WordSelectEvent(
    this.wordModel,
  );

  final WordModel wordModel;
}

class SelectEvent extends WordEvent {
  SelectEvent(// this.morphologicalModel,
      );

// final MophologicalModel morphologicalModel;
}

class WordLoadMoreEvent extends WordEvent {} // Новый Event для подгрузки
