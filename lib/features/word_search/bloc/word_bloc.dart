import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphology_finder/features/word_search/data/models/word.dart';
import 'package:morphology_finder/features/word_search/data/repositories/word_repository.dart';
import 'package:morphology_finder/main.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final WordRepository _wordRepository;

  WordBloc(
    this._wordRepository,
  ) : super(WordInitialState()) {
    on<WordTextChangeEvent>(_onTextChange);
    on<WordSelectEvent>(_onWordSelect);
  }

  Future<void> _onTextChange(
      WordTextChangeEvent event, Emitter<WordState> emit) async {
    debugPrint('Word Search Text Change Event');

    if (event.query.isEmpty) {
      emit(WordInitialState());
      return;
    }

    emit(WordLoadingState());

    try {
      final word = await _wordRepository.getWordId(event.query);

      emit(WordLoadedState(word));
    } catch (e, s) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: s);

      emit(WordFailureState(e.toString()));
    }
  }
}

Future<void> _onWordSelect(
    WordSelectEvent event, Emitter<WordState> emit) async {
  // final dbFile = await getDatabaseFile();
  final allWords = await (db.select(db.wordItems)..limit(20)).get();
  // print(allWords);
  // // debugPrint('Location Select Event');
  // emit(LocationSearchLoadingState());
  //
  // // try {
  // //   final localizedNameForWeatherData =
  // //       await geoPositionSearchForWeatherRepository.fetchLocalizedName(
  // //     lat: event.locationDetailsModel.lat ?? 0.0,
  // //     lng: event.locationDetailsModel.lng ?? 0.0,
  // //   );
  // //
  // //   debugPrint(
  // //       'This Is Success: ${localizedNameForWeatherData.localizedName}');
  //   emit(LocationSelectedState(localizedNameForWeatherData.localizedName));
  // } catch (e, s) {
  //   debugPrint('Error: $e');
  //   debugPrintStack(stackTrace: s);
  //   emit(LocationSearchFailureState(e.toString()));
  // }
  debugPrint('Word Select Event');
}
