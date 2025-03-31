import 'package:flutter_web_worker_example/core/db/db.dart';
import 'package:flutter_web_worker_example/features/word_search/data/models/word.dart';

class AggregatedWordModel {
  final WordModel wordModel;
  final Alternation? info;

  AggregatedWordModel({
    required this.wordModel,
    required this.info,
  });
}