import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_web_worker_example/features/spreadsheet/data/models/spreadsheet_model.dart';
import 'package:flutter_web_worker_example/features/spreadsheet/data/repositories/spreadsheet_repository.dart';

part 'spreadsheet_event.dart';

part 'spreadsheet_state.dart';

class SpreadsheetBloc extends Bloc<SpreadsheetEvent, SpreadsheetState> {
  final SpreadsheetRepository repository;

  SpreadsheetBloc(this.repository) : super(SpreadsheetInitialState()) {
    on<SpreadsheetLoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
      SpreadsheetLoadEvent event, Emitter<SpreadsheetState> emit) async {
    emit(SpreadsheetLoadingState());

    try {
      final aggregatedList = await repository.fetchSpreadsheetData();

      emit(SpreadsheetLoadedState(aggregatedList));
    } catch (e, s) {
      debugPrint('Ошибка загрузки данных: $e');
      debugPrintStack(stackTrace: s);
      emit(SpreadsheetFailureState(e.toString()));
    }
  }
}
