import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

part 'db.g.dart';

@DataClassName('Word')
class WordItems extends Table {
  IntColumn get idPr => integer().autoIncrement()(); // Primary key

  IntColumn get id => integer()();

  TextColumn get basic_word => text()();

  TextColumn get split_word => text()();
}

@DataClassName('Alternation')
class AlternationItems extends Table {
  IntColumn get idPr => integer().autoIncrement()(); // Primary key

  IntColumn get id => integer()();

  IntColumn get wordId => integer()();

  TextColumn get morphology_process => text()();
  TextColumn get explanation => text()();
  TextColumn? get meaning => text()();
}

@DriftDatabase(tables: [WordItems, AlternationItems])
class Database extends _$Database {
  Database(super.executor);

  @override
  int get schemaVersion => 1;
}

Future<void> loadJsonAndInsert(Database db) async {
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
      explanation: item['explanation'],
      morphology_process: item['morphology_process'],
      meaning: item['meaning'],
      // Add other fields here...
    );

    await db.into(db.alternationItems).insertOnConflictUpdate(row);
  }

  print('✅ Data inserted into Drift DB2');
}
