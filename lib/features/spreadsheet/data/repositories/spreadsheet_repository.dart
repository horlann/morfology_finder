import 'package:flutter/material.dart';

import 'package:flutter_web_worker_example/core/db/db.dart';
import 'package:flutter_web_worker_example/features/spreadsheet/data/models/spreadsheet_model.dart';
import 'package:flutter_web_worker_example/features/word_search/data/models/word.dart';
import 'package:flutter_web_worker_example/main.dart';

class SpreadsheetRepository {
  SpreadsheetRepository();

  Future<List<SpreadsheetModel>> fetchSpreadsheetData() async {
    try {
      final alt = await (database.select(database.alternationItems)).get();
      final ids = alt.map((e) => e.wordId).toList();
      final words = await (database.select(database.wordItems)
            ..where((tbl) => tbl.id.isIn(ids)))
          .get();

      return alt.map((altItem) {
        final matchingWord = words.firstWhere(
          (word) => word.id == altItem.wordId,
          orElse: () => Word(
            idPr: 0,
            id: 0,
            basic_word: '',
            split_word: '',
          ),
        );

        return SpreadsheetModel(
          wordModel: WordModel(
            wordId: matchingWord.id,
            wordBasicWord: matchingWord.basic_word,
            wordSplitWord: matchingWord.split_word,
          ),
          info: altItem,
        );
      }).toList();
    } catch (e, s) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: s);
      return [];
    }
  }
}
