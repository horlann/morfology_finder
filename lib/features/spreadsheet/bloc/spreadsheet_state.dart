part of 'spreadsheet_bloc.dart';

@immutable
sealed class SpreadsheetState extends Equatable {}

final class SpreadsheetInitialState extends SpreadsheetState {
  @override
  List<Object?> get props => [];
}

class SpreadsheetLoadingState extends SpreadsheetState {
  @override
  List<Object?> get props => [];
}

class SpreadsheetLoadedState extends SpreadsheetState {
  SpreadsheetLoadedState(
    this.words,
  );

  final List<SpreadsheetModel> words;

  @override
  List<Object?> get props => [words];
}

class SpreadsheetFailureState extends SpreadsheetState {
  SpreadsheetFailureState(
    this.error,
  );

  final String error;

  @override
  List<Object?> get props => [error];
}
