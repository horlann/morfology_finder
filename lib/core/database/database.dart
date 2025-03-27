// import 'package:drift/drift.dart';
//
// part 'database.g.dart';
//
// @DataClassName('Word')
// class WordItems extends Table {
//   IntColumn get idPr => integer().autoIncrement()(); // Primary key
//
//   IntColumn get id => integer()();
//
//   TextColumn get basic_word => text()();
//
//   TextColumn get split_word => text()();
// }
//
// @DriftDatabase(tables: [WordItems])
// class MyDatabase extends _$MyDatabase {
//   MyDatabase(super.executor);
//
//   @override
//   int get schemaVersion => 1;
// }
