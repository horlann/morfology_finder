import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_worker_example/features/word_search/data/models/word.dart';
import 'package:flutter_web_worker_example/features/word_search/data/repositories/word_repository.dart';
import 'package:flutter_web_worker_example/main.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final WordRepository _wordRepository;
  final int _pageSize = 20; // Количество слов на странице
  int _currentPage = 0; // Текущая страница
  bool _isLoadingMore = false; // Флаг загрузки
  String _currentQuery = ""; // Текущий поисковый запрос

  WordBloc(this._wordRepository) : super(WordInitialState()) {
    on<WordInitEvent>(_onInit);
    on<WordTextChangeEvent>(_onTextChange);
    on<WordSelectEvent>(_onWordSelect);
    on<WordLoadMoreEvent>(_onLoadMore);

    add(WordInitEvent());
  }

  /// 📌 Метод инициализации (загрузка первой страницы)
  Future<void> _onInit(WordInitEvent event, Emitter<WordState> emit) async {
    try {
      _currentPage = 0;
      _currentQuery = ""; // Очистить поисковой запрос

      final allWords = await _fetchWords(page: _currentPage, query: "");

      emit(WordLoadedState(allWords));
    } catch (e, s) {
      debugPrint('Error loading words (init bloc): $e');
      debugPrintStack(stackTrace: s);
      emit(WordFailureState(e.toString()));
    }
  }

  /// 📌 Метод поиска по слову
  Future<void> _onTextChange(
      WordTextChangeEvent event, Emitter<WordState> emit) async {
    debugPrint('Word Search Text Change Event: ${event.query}');

    _currentQuery = event.query.trim();
    _currentPage = 0; // Сбросить страницу при новом поиске

    if (_currentQuery.isEmpty) {
      add(WordInitEvent()); // Если строка пустая — загрузить стандартные данные
      return;
    }

    emit(WordLoadingState());

    try {
      final searchResults =
          await _fetchWords(page: _currentPage, query: _currentQuery);

      emit(WordLoadedState(searchResults));
    } catch (e, s) {
      debugPrint('Error during search: $e');
      debugPrintStack(stackTrace: s);
      emit(WordFailureState(e.toString()));
    }
  }

  /// 📌 Метод подгрузки следующей страницы
  Future<void> _onLoadMore(
      WordLoadMoreEvent event, Emitter<WordState> emit) async {
    if (_isLoadingMore || state is! WordLoadedState) return;

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

      final currentState = state as WordLoadedState;
      final updatedWordList = List<WordModel>.from(currentState.words)
        ..addAll(moreWords);

      emit(WordLoadedState(updatedWordList));
    } catch (e, s) {
      debugPrint('Error loading more words: $e');
      debugPrintStack(stackTrace: s);
    } finally {
      _isLoadingMore = false;
    }
  }

  /// 📌 Метод выбора слова
  Future<void> _onWordSelect(
      WordSelectEvent event, Emitter<WordState> emit) async {}

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
