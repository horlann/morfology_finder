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

  // runApp(MaterialApp(
  //   title: 'Flutter web worker example',
  //   home: Scaffold(
  //     body: _DatabaseSample(),
  //   ),
  // ));
}

// class _DatabaseSampleState extends State<_DatabaseSample> {
//   List<Entry> allItems = [];
//   TextEditingController editController = TextEditingController();
//   final database = MyDatabase(Platform.createDatabaseConnection('sample'));
//
//   void addPressed() {
//     database.into(database.entries).insert(
//         EntriesCompanion(value: drift.Value(editController.text.toString())));
//   }
//
//   @override
//   void initState() {
//     database.allEntries().watch().listen((event) {
//       setState(() {
//         allItems = event;
//       });
//     });
//     loadJsonAndInsert(database);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             width: 200,
//             child: TextField(
//               controller: editController,
//               decoration: const InputDecoration(border: OutlineInputBorder()),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 20),
//             child:
//                 ElevatedButton(onPressed: addPressed, child: const Text('Add')),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(bottom: 10),
//             child: Text(
//               'Entries',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//           ),
//           for (var e in allItems) Text(e.value),
//         ],
//       ),
//     );
//   }
// }
//
// class _DatabaseSample extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _DatabaseSampleState();
// }

Future<void> loadJsonAndInsert(Database db) async {
  final jsonString = await rootBundle.loadString('assets/data/word.json');
  final List<dynamic> jsonList = json.decode(jsonString);
  final list2 = jsonList.sublist(0, 10);
  for (var item in list2) {
    final entry = Word(
        id: item['id'],
        idPr: item['id'],
        basic_word: item['basic_word'],
        split_word: item['split_word']);
    // final row = Word(
    //   id: item['id'],
    //   basic_word: item['basic_word'],
    //   split_word: item['split_word'], idPr: item['id'],
    //   // Add other fields here...
    // )
    await db.into(db.wordItems).insertOnConflictUpdate(entry);
  }

  print('✅ Data inserted into Drift DB');
}
