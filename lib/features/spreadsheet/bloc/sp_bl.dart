import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_web_worker_example/core/db/db.dart';
import 'package:flutter_web_worker_example/features/spreadsheet/data/models/aggregated_word.dart';
import 'package:flutter_web_worker_example/features/word_search/data/models/word.dart';

import '../../../main.dart';

// 🎯 Определение событий
abstract class SpreadsheetEvent {}

class SpreadsheetLoadEvent extends SpreadsheetEvent {}

// 🎯 Определение состояний
abstract class SpreadsheetState {}

class SpreadsheetInitialState extends SpreadsheetState {}

class SpreadsheetLoadingState extends SpreadsheetState {}

class SpreadsheetLoadedState extends SpreadsheetState {
  final List<AggregatedWordModel> words;

  SpreadsheetLoadedState(this.words);
}

class SpreadsheetFailureState extends SpreadsheetState {
  final String error;

  SpreadsheetFailureState(this.error);
}

// 🎯 Bloc для загрузки данных
class SpreadsheetBloc extends Bloc<SpreadsheetEvent, SpreadsheetState> {
  SpreadsheetBloc() : super(SpreadsheetInitialState()) {
    on<SpreadsheetLoadEvent>(_onLoad);

    add(SpreadsheetLoadEvent()); // Загружаем данные при запуске
  }

  /// 📌 Метод загрузки данных из таблицы
  Future<void> _onLoad(
      SpreadsheetLoadEvent event, Emitter<SpreadsheetState> emit) async {
    emit(SpreadsheetLoadingState());

    try {
      final alt = await (database.select(database.alternationItems)).get();
      final ids = alt.map((e) => e.wordId).toList();
      final words = await (database.select(database.wordItems)
            ..where((tbl) => tbl.id.isIn(ids)))
          .get();
      final aggregatedList = alt.map((altItem) {
        final matchingWord =
            words.firstWhere((word) => word.id == altItem.wordId,
                orElse: () => Word(
                      idPr: 0,
                      id: 0,
                      basic_word: '',
                      split_word: '',
                    ));

        return AggregatedWordModel(
          wordModel: WordModel(
            wordId: matchingWord.id,
            wordBasicWord: matchingWord.basic_word,
            wordSplitWord: matchingWord.split_word,
          ),
          info: altItem,
        );
      }).toList();
      emit(SpreadsheetLoadedState(aggregatedList));
    } catch (e, s) {
      debugPrint('Ошибка загрузки данных: $e');
      debugPrintStack(stackTrace: s);
      emit(SpreadsheetFailureState(e.toString()));
    }
  }
}


