part of 'word_search_bloc.dart';

@immutable
sealed class WordSearchState extends Equatable {}

final class WordInitialState extends WordSearchState {
  @override
  List<Object?> get props => [];
}

class WordSearchLoadingState extends WordSearchState {
  @override
  List<Object?> get props => [];
}

class WordSearchLoadedState extends WordSearchState {
  WordSearchLoadedState(
    this.words,
  );

  final List<WordModel> words;

  @override
  List<Object?> get props => [words];
}

class WordSearchFailureState extends WordSearchState {
  WordSearchFailureState(
    this.exception,
  );

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}

class WordSearchSelectedState extends WordSearchState {
  final String wordBasicWord;

  WordSearchSelectedState(this.wordBasicWord,);

  @override
  List<Object> get props => [wordBasicWord];
}

class WordSearchSelectedFailureState extends WordSearchState {
  WordSearchSelectedFailureState(
    this.exception,
  );

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
