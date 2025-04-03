part of 'word_details_bloc.dart';

@immutable
sealed class WordDetailsState extends Equatable {}

final class WordDetailsInitialState extends WordDetailsState {
  @override
  List<Object?> get props => [];
}

class WordDetailsLoadingState extends WordDetailsState {
  @override
  List<Object?> get props => [];
}

class WordDetailsLoadedState extends WordDetailsState {
  WordDetailsLoadedState(this.wordModel);

  final SpreadsheetModel wordModel;


  @override
  List<Object?> get props => [wordModel];
}

class WordDetailsFailureState extends WordDetailsState {
  WordDetailsFailureState(this.exception);

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
