import 'package:drift/wasm.dart';
import 'package:flutter/material.dart';

import 'package:morphology_finder/morphology_app.dart';

import 'core/db/db.dart';

late Database db;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MorphologyApp());
  dbbb();
}

void dbbb() async {
  final connection = await WasmDatabase.open(
    databaseName: 'worker',
    sqlite3Uri: Uri.parse('/sqlite3.wasm'),
    driftWorkerUri: Uri.parse('/worker.dart.js'),
  );

  print('Opened WASM database: ${connection.chosenImplementation}');

  db = Database(connection.resolvedExecutor);
  loadJsonAndInsert(db);
}
