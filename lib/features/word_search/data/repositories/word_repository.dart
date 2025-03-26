import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:morphology_finder/features/word_search/data/models/word.dart';

class WordRepository {
  Future<WordModel> getWordId(String query) async {
    await Future.delayed(Duration(milliseconds: 500));
    String mockData = '''
[
  {
    "id": 21,
    "basic_word": "абсолютність",
    "split_word": "абсолю́т/н/ість",  
  }
]
''';

    final data = jsonDecode(mockData);

    debugPrint('getWordId: ${data['id']}; '
        '${data['basic_word']}; '
        '${data['split_word']}');

    final wordId = data['id'];
    final wordBasicWord = data['basic_word'];
    final wordSplitWord = data['split_word'];

    return WordModel(
      wordId: wordId,
      wordBasicWord: wordBasicWord,
      wordSplitWord: wordSplitWord,
    );
  }
}
