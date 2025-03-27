part of 'word_bloc.dart';

@immutable
sealed class WordState extends Equatable {}

final class WordInitialState extends WordState {
  @override
  List<Object?> get props => [];
}

class WordLoadingState extends WordState {
  @override
  List<Object?> get props => [];
}

class WordLoadedState extends WordState {
  WordLoadedState(
    this.words,
  );

  final List<WordModel> words;

  @override
  List<Object?> get props => [words];
}

class WordFailureState extends WordState {
  WordFailureState(
    this.exception,
  );

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}

class WordSelectedState extends WordState {
  final String wordBasicWord;

  WordSelectedState(this.wordBasicWord,);

  @override
  List<Object> get props => [wordBasicWord];
}

class WordSelectedFailureState extends WordState {
  WordSelectedFailureState(
    this.exception,
  );

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
