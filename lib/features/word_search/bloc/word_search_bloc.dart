import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:drift/drift.dart';

import 'package:flutter_web_worker_example/main.dart';
import 'package:flutter_web_worker_example/features/word_search/data/models/word.dart';

part 'word_search_event.dart';

part 'word_search_state.dart';

class WordSearchBloc extends Bloc<WordSearchEvent, WordSearchState> {
  // final WordRepository _wordRepository;
  final int _pageSize = 20; // Количество слов на странице
  int _currentPage = 0; // Текущая страница
  bool _isLoadingMore = false; // Флаг загрузки
  String _currentQuery = ''; // Текущий поисковый запрос

  WordSearchBloc() : super(WordInitialState()) {
    on<WordSearchInitEvent>(_onInit);
    on<WordSearchTextChangeEvent>(_onTextChange);
    on<WordSearchSelectEvent>(_onWordSelect);
    on<WordSearchLoadMoreEvent>(_onLoadMore);

    add(WordSearchInitEvent());
  }

  /// 📌 Метод инициализации (загрузка первой страницы)
  Future<void> _onInit(WordSearchInitEvent event, Emitter<WordSearchState> emit) async {
    try {
      _currentPage = 0;
      _currentQuery = ""; // Очистить поисковой запрос

      final allWords = await _fetchWords(page: _currentPage, query: '');

      emit(WordSearchLoadedState(allWords));
    } catch (e, s) {
      debugPrint('Error loading words (init bloc): $e');
      debugPrintStack(stackTrace: s);
      emit(WordSearchFailureState(e.toString()));
    }
  }

  /// 📌 Метод поиска по слову
  Future<void> _onTextChange(
      WordSearchTextChangeEvent event, Emitter<WordSearchState> emit) async {
    debugPrint('Word Search Text Change Event: ${event.query}');

    _currentQuery = event.query.trim();
    _currentPage = 0; // Сбросить страницу при новом поиске

    if (_currentQuery.isEmpty) {
      add(WordSearchInitEvent()); // Если строка пустая — загрузить стандартные данные
      return;
    }

    emit(WordSearchLoadingState());

    try {
      final searchResults =
          await _fetchWords(page: _currentPage, query: _currentQuery);

      emit(WordSearchLoadedState(searchResults));
    } catch (e, s) {
      debugPrint('Error during search: $e');
      debugPrintStack(stackTrace: s);
      emit(WordSearchFailureState(e.toString()));
    }
  }

  /// 📌 Метод подгрузки следующей страницы
  Future<void> _onLoadMore(
      WordSearchLoadMoreEvent event, Emitter<WordSearchState> emit) async {
    if (_isLoadingMore || state is! WordSearchLoadedState) return;

    _isLoadingMore = true;
    debugPrint('Loading more words...');

    try {
      _currentPage++;

      final moreWords =
          await _fetchWords(page: _currentPage, query: _currentQuery);

      if (moreWords.isEmpty) {
        debugPrint('No more words to load.');
        return;
      }

      final currentState = state as WordSearchLoadedState;
      final updatedWordList = List<WordModel>.from(currentState.words)
        ..addAll(moreWords);

      emit(WordSearchLoadedState(updatedWordList));
    } catch (e, s) {
      debugPrint('Error loading more words: $e');
      debugPrintStack(stackTrace: s);
    } finally {
      _isLoadingMore = false;
    }
  }

  /// 📌 Метод выбора слова
  Future<void> _onWordSelect(
      WordSearchSelectEvent event, Emitter<WordSearchState> emit) async {}

  /// 📌 Метод получения слов (пагинация + поиск)
  Future<List<WordModel>> _fetchWords(
      {required int page, required String query}) async {
    final queryBuilder = database.select(database.wordItems)
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.id)]) // Сортировка по ID
      ..limit(_pageSize);

    if (query.isNotEmpty) {
      queryBuilder.where((tbl) =>
          tbl.basic_word.like('%$query%') |
          tbl.split_word.like('%$query%')); // Поиск по двум столбцам
    } else if (page > 0) {
      queryBuilder.where((tbl) =>
          tbl.id.isBiggerThanValue(page * _pageSize)); // Пагинация без `offset`
    }

    final results = await queryBuilder.get();

    return results
        .map((e) => WordModel(
            wordId: e.id,
            wordBasicWord: e.basic_word,
            wordSplitWord: e.split_word))
        .toList();
  }
}
