import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_web_worker_example/features/spreadsheet/data/models/aggregated_word.dart';
import 'package:flutter_web_worker_example/features/word_search/data/models/word.dart';
import 'package:flutter_web_worker_example/main.dart';

part 'word_details_event.dart';

part 'word_details_state.dart';

class WordDetailsBloc extends Bloc<WordDetailsEvent, WordDetailsState> {
  final WordModel wordModel;

  WordDetailsBloc(this.wordModel) : super(WordDetailsInitialState()) {
    on<WordDetailsSelectEvent>(_onWordSelected);
  }

  Future<void> _onWordSelected(
      WordDetailsSelectEvent event, Emitter<WordDetailsState> emit) async {
    emit(WordDetailsLoadingState());

    try {
      final info = (await (database.select(database.alternationItems)
                ..where((tbl) => tbl.wordId.equals(wordModel.wordId)))
              .get())
          .firstOrNull;

      emit(WordDetailsLoadedState(
          AggregatedWordModel(wordModel: wordModel, info: info)));



    } catch (e, s) {
      debugPrint('Ошибка при загрузке морфологии: $e');
      debugPrintStack(stackTrace: s);
      emit(WordDetailsFailureState(e.toString()));
    }
  }
}
