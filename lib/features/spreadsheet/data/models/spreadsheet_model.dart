import 'package:flutter_web_worker_example/core/db/db.dart';
import 'package:flutter_web_worker_example/features/word_search/data/models/word.dart';

class SpreadsheetModel {
  final WordModel wordModel;
  final Alternation? info;

  SpreadsheetModel({
    required this.wordModel,
    required this.info,
  });
}