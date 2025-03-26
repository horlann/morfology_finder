import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/web.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/services.dart';

part 'db.g.dart';

@DataClassName('Word')
class WordItems extends Table {
  IntColumn get idPr => integer().autoIncrement()(); // Primary key

  IntColumn get id => integer()();

  TextColumn get basic_word => text()();

  TextColumn get split_word => text()();
}

@DriftDatabase(tables: [WordItems])
class Database extends _$Database {
  Database(DatabaseConnection super.e);

  @override
  int get schemaVersion => 1;
}

// LazyDatabase _openConnection(File dbFile) {
//   return LazyDatabase(() async {
//     return NativeDatabase(dbFile);
//   });
// }

// Future<File> getDatabaseFile() async {
//   final dbName = 'morphology.db';
//
//   final documents = await getApplicationDocumentsDirectory();
//   final dbPath = p.join(documents.path, dbName);
//
//   final dbFile = File(dbPath);
//
//   if (!await dbFile.exists()) {
//     // Copy from assets
//     final data = await rootBundle.load('db/$dbName');
//     final bytes = data.buffer.asUint8List();
//     await dbFile.writeAsBytes(bytes, flush: true);
//   }
//
//   return dbFile;
// }
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
