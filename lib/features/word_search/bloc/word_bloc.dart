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
  final int _pageSize = 20; // Количество слов на одной странице
  int _currentPage = 0; // Текущая страница
  bool _isLoadingMore = false; // Флаг загрузки следующей страницы

  WordBloc(this._wordRepository) : super(WordInitialState()) {
    on<WordInitEvent>(_onInit);
    on<WordTextChangeEvent>(_onTextChange);
    on<WordSelectEvent>(_onWordSelect);
    on<WordLoadMoreEvent>(_onLoadMore);

    add(WordInitEvent());
  }

  Future<void> _onInit(WordInitEvent event, Emitter<WordState> emit) async {
    try {
      _currentPage = 0; // Сброс страницы при инициализации

      final allWords =
          await (database.select(database.wordItems)..limit(_pageSize)).get();

      final wordList = allWords
          .map((e) => WordModel(
              wordId: e.id,
              wordBasicWord: e.basic_word,
              wordSplitWord: e.split_word))
          .toList();

      emit(WordLoadedState(wordList));
    } catch (e, s) {
      debugPrint('Error loading words (init bloc): $e');
      debugPrintStack(stackTrace: s);
      emit(WordFailureState(e.toString()));
    }
  }

  Future<void> _onLoadMore(
      WordLoadMoreEvent event, Emitter<WordState> emit) async {
    if (_isLoadingMore || state is! WordLoadedState) return;

    _isLoadingMore = true;
    debugPrint('Loading more words...');

    try {
      final currentState = state as WordLoadedState;
      final lastWordId =
          currentState.words.isNotEmpty ? currentState.words.last.wordId : 0;

      final moreWords = await (database.select(database.wordItems)
            ..where((tbl) => tbl.id.isBiggerThanValue(lastWordId))
            ..orderBy(
                [(tbl) => OrderingTerm(expression: tbl.id)]) // Сортировка по id
            ..limit(_pageSize))
          .get();

      if (moreWords.isEmpty) {
        debugPrint('No more words to load.');
        return;
      }

      final updatedWordList = List<WordModel>.from(currentState.words)
        ..addAll(moreWords.map((e) => WordModel(
            wordId: e.id,
            wordBasicWord: e.basic_word,
            wordSplitWord: e.split_word)));

      emit(WordLoadedState(updatedWordList));
    } catch (e, s) {
      debugPrint('Error loading more words: $e');
      debugPrintStack(stackTrace: s);
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> _onTextChange(
      WordTextChangeEvent event, Emitter<WordState> emit) async {
    debugPrint('Word Search Text Change Event');

    if (event.query.isEmpty) {
      emit(WordInitialState());
      return;
    }

    emit(WordLoadingState());

    try {} catch (e, s) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: s);
      emit(WordFailureState(e.toString()));
    }
  }

  Future<void> _onWordSelect(
      WordSelectEvent event, Emitter<WordState> emit) async {
    debugPrint('Word Select Event');
  }
}
