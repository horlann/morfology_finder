import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_worker_example/core/db/db.dart';
import 'package:flutter_web_worker_example/features/word_search/data/models/word.dart';

import '../../../main.dart';

// 🎯 Определение событий
abstract class SpreadshitEvent {}

class SpreadshitLoadEvent extends SpreadshitEvent {}

// 🎯 Определение состояний
abstract class SpreadshitState {}

class SpreadshitInitialState extends SpreadshitState {}

class SpreadshitLoadingState extends SpreadshitState {}

class SpreadshitLoadedState extends SpreadshitState {
  final List<AggregatedWordModel> words;

  SpreadshitLoadedState(this.words);
}

class SpreadshitFailureState extends SpreadshitState {
  final String error;

  SpreadshitFailureState(this.error);
}

// 🎯 Bloc для загрузки данных
class SpreadshitBloc extends Bloc<SpreadshitEvent, SpreadshitState> {
  SpreadshitBloc() : super(SpreadshitInitialState()) {
    on<SpreadshitLoadEvent>(_onLoad);

    add(SpreadshitLoadEvent()); // Загружаем данные при запуске
  }

  /// 📌 Метод загрузки данных из таблицы
  Future<void> _onLoad(
      SpreadshitLoadEvent event, Emitter<SpreadshitState> emit) async {
    emit(SpreadshitLoadingState());

    try {
      final alt = await (database.select(database.alternationItems)).get();
      final ids = alt.map((e) => e.wordId).toList();
      final words = await (database.select(database.wordItems)
            ..where((tbl) => tbl.id.isIn(ids)))
          .get();
      final aggregatedList = alt.map((altItem) {
        final matchingWord = words.firstWhere(
          (word) => word.id == altItem.wordId,
        );

        return AggregatedWordModel(
          wordModel: WordModel(
            wordId: matchingWord.id,
            wordBasicWord: matchingWord.basic_word,
            wordSplitWord: matchingWord.split_word,
          ),
          info: altItem,
        );
      }).toList();
      emit(SpreadshitLoadedState(aggregatedList));
    } catch (e, s) {
      debugPrint('Ошибка загрузки данных: $e');
      debugPrintStack(stackTrace: s);
      emit(SpreadshitFailureState(e.toString()));
    }
  }
}

class AggregatedWordModel {
  final WordModel wordModel;
  final Alternation info;

  AggregatedWordModel({required this.wordModel, required this.info});
}
