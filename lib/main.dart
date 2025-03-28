import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/db/db.dart';
import 'morphology_app.dart';
import 'src/platform/platform.dart';

late Database database;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MorphologyApp());
  database = Database(Platform.createDatabaseConnection('sample'));
  loadJsonAndInsert(database);
  loadJsonAndInsert2(database);
}

ndInsert(Database db) async {
  final jsonString = await rootBundle.loadString('assets/data/word.json');
  final List<dynamic> jsonList = json.decode(jsonString);

  for (var item in jsonList) {
    final row = Word(
      id: item['id'],
      basic_word: item['basic_word'],
      split_word: item['split_word'], idPr: item['id'],
      // Add other fields here...
    );

    await db.into(db.wordItems).insertOnConflictUpdate(row);
  }

  print('✅ Data inserted into Drift DB');
}

Future<void> loadJsonAndInsert2(Database db) async {
  final jsonString =
      await rootBundle.loadString('assets/data/alternation.json');
  final List<dynamic> jsonList = json.decode(jsonString);

  for (var item in jsonList) {
    final row = Alternation(
      id: item['id'],
      idPr: item['id'],
      wordId: item['word_id'],
      morphology_process: item['morphology_process'],
      explanation: item['explanation'],
      // Add other fields here...
    );

    await db.into(db.alternationItems).insertOnConflictUpdate(row);
  }

  print('✅ Data inserted into Drift DB2');
}
