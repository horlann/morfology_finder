import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:flutter/foundation.dart';

class PlatformInterface {
  static QueryExecutor createDatabaseConnection(String databaseName) {
    return DatabaseConnection.delayed(Future(() async {
      final base = 'sqlite3.wasm';
      final baseUri = kReleaseMode
          ? 'https://horlann.github.io/morfology/$base'
          : Uri.base.resolve(base).toString();
      final database = await WasmDatabase.open(
        databaseName: databaseName,
        sqlite3Uri: Uri.parse(baseUri),
        driftWorkerUri: Uri.parse(
          kReleaseMode ? '/worker.dart.min.js' : '/worker.dart.js',
        ),
      );
      return database.resolvedExecutor;
    }));
  }
}
