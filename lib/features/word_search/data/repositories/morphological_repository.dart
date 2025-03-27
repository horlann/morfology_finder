import 'package:flutter/material.dart';
import 'package:flutter_web_worker_example/features/word_search/data/models/morphological.dart';

import 'dart:convert';

class MorphologicalRepository {
  Future<MorphologicalModel> getMorphologicalAlternation({
    required int wordId,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    String mockData = '''
[
  {
    "id": 1,
    "word_id": 6,
    "morphology_process": "(~тц/і, ~ток)",  
    "meaning": "",  
    "explanation": "чергування приголосних [к] - [ц] перед [і] в давальному та 
    місцевому відмінках однини іменника жіночого роду І відміни.;чергування 
    нуля звука з [о] в родовому відмінку множини іменників.",  
    "type": "чергування"  
  },
  {
    "id": 2,
    "word_id": 9,
    "morphology_process": "(~т/ц/і, ~т/ок)",  
    "meaning": "",  
    "explanation": "чергування приголосних [к] - [ц] перед [і] в давальному та
    місцевому відмінках однини іменника жіночого роду І відміни.;чергування 
    нуля звука з [о] в родовому відмінку множини іменників.",  
    "type": "чергування"
  }
]
''';

    final data = jsonDecode(mockData);

    debugPrint('getMorphologicalAlternation: ${data['id']}; '
        '${data['word_id']}; '
        '${data['morphology_process']}; '
        '${data['meaning']}; '
        '${data['explanation']}; '
        '${data['type']}');

    final morphologicalId = data['id'];
    final morphologicalWordId = data['word_id'];
    final morphologicalMorphologyProcess = data['morphology_process'];
    final morphologicalMeaning = data['meaning'];
    final morphologicalExplanation = data['explanation'];
    final morphologicalType = data['type'];

    return MorphologicalModel(
      morphologicalId: morphologicalId,
      morphologicalWordId: morphologicalWordId,
      morphologicalMorphologyProcess: morphologicalMorphologyProcess,
      morphologicalMeaning: morphologicalMeaning,
      morphologicalExplanation: morphologicalExplanation,
      morphologicalType: morphologicalType,
    );
  }
}
