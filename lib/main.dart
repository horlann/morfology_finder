import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter_web_worker_example/core/db/db.dart';
import 'package:flutter_web_worker_example/services/app_loading_indicator.dart';
import 'package:flutter_web_worker_example/src/platform/platform.dart';

late Database database;
final stopwatch = Stopwatch();
final ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppLoadingIndicator());
  stopwatch.start();
  database = Database(Platform.createDatabaseConnection('sample'));
  _initializeDatabase();
}

Future<void> _initializeDatabase() async {
  isLoadingNotifier.value = true;
  await loadJsonAndInsert(database);
  await loadJsonAndInsert2(database);
  isLoadingNotifier.value = false;
}

Future<void> loadJsonAndInsert(Database db) async {
  final jsonString = await rootBundle.loadString('assets/data/word.json');
  final words = await compute(parseWords, jsonString);

  await db.batch((batch) {
    batch.insertAll(db.wordItems, words, mode: InsertMode.insertOrReplace);
  });

  debugPrint('✅ Data inserted into Drift DB');
}

Future<void> loadJsonAndInsert2(Database db) async {
  final jsonString =
      await rootBundle.loadString('assets/data/alternation.json');
  final alternations = await compute(parseAlternations, jsonString);

  await db.batch((batch) {
    batch.insertAll(db.alternationItems, alternations,
        mode: InsertMode.insertOrReplace);
  });
  stopwatch.stop();
  debugPrint('✅ Data batch-inserted in ${stopwatch.elapsedMilliseconds} ms');

  debugPrint('✅ Data inserted into Drift DB2');
}

Future<List<Word>> parseWords(String jsonString) async {
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList
      .map((item) => Word(
            id: item['id'],
            basic_word: item['basic_word'],
            split_word: item['split_word'],
            idPr: item['id'],
          ))
      .toList();
}

Future<List<Alternation>> parseAlternations(String jsonString) async {
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList
      .map((item) => Alternation(
            id: item['id'],
            idPr: item['id'],
            wordId: item['word_id'],
            morphology_process: item['morphology_process'],
            explanation: item['explanation'],
            meaning: item['meaning'],
          ))
      .toList();
}
