import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_web_worker_example/features/spreadsheet/bloc/spreadsheet_bloc.dart';
import 'package:flutter_web_worker_example/features/spreadsheet/data/models/spreadsheet_model.dart';

class WordTableScreen extends StatefulWidget {
  const WordTableScreen({
    super.key,
  });

  @override
  _WordTableScreenState createState() => _WordTableScreenState();
}

class _WordTableScreenState extends State<WordTableScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.95) {
      // context.read<SpreadsheetBloc>().add(WordLoadMoreEvent()); // Подгрузка следующей страницы
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BlocBuilder<SpreadsheetBloc, SpreadsheetState>(
        builder: (context, state) {
          if (state is SpreadsheetLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SpreadsheetFailureState) {
            return Center(child: Text('Ошибка: ${state.error}'));
          } else if (state is SpreadsheetLoadedState) {
            final words = state.words;

            return SingleChildScrollView(
              padding: EdgeInsets.zero,
              controller: _scrollController,
              child: DataTableTheme(
                data: DataTableThemeData(
                  decoration: BoxDecoration(color: Colors.white),
                  headingRowColor:
                      WidgetStateProperty.all(Colors.white), // Header row color
                  dataRowColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white; // Row color when selected
                      }
                      return Colors.white; // Default row color
                    },
                  ),
                ),
                child: Material(
                  color: Colors.white,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      cardColor: Colors.white,
                      cardTheme: CardTheme(
                        color: Colors.white,
                        // ✅ Make all cards pure white
                        surfaceTintColor: Colors.white,
                        // ✅ Remove elevation tint
                        shadowColor: Colors.transparent,
                        // ✅ Remove shadow
                        elevation: 0,
                        margin: EdgeInsets.zero,

                        // ✅ No shadow effect
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius
                              .zero, // ✅ Remove rounded corners if needed
                          side: BorderSide(
                              color: Colors.white), // ✅ Ensures no border color
                        ),
                      ),
                      dividerColor: Colors.white,
                      dataTableTheme: DataTableThemeData(
                        headingRowColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          // Set color for heading row
                          return Colors.white; // example color
                        }),
                        dataRowColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          // Set color for data rows
                          return Colors.white; // example color
                        }),
                        // Add other customizations here
                      ),
                    ),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.zero,
                      child: PaginatedDataTable(
                        columns: [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Word ID')),
                          DataColumn(label: Text('Morphology Process')),
                          DataColumn(label: Text('Meaning')),
                          DataColumn(label: Text('Explanation')),
                          // DataColumn(label: Text('Type')),
                        ],
                        source: _WordDataTableSource(words),
                        // Количество строк на странице
                        rowsPerPage: 10,
                        horizontalMargin: 16,
                        headingRowColor: WidgetStateProperty.all(Colors.white),
                        arrowHeadColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Center(
            child: Text('Немає даних'),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _WordDataTableSource extends DataTableSource {
  final List<SpreadsheetModel> words;

  _WordDataTableSource(this.words);

  @override
  DataRow getRow(int index) {
    if (index >= words.length) {
      return DataRow(
        cells: [
          DataCell(Text('-')),
          DataCell(Text('-')),
          DataCell(Text('-')),
          DataCell(Text('-')),
          DataCell(Text('-')),
        ],
      );
    }
    final word = words[index];

    return DataRow(
      cells: [
        DataCell(Text(word.wordModel.wordId.toString())),
        DataCell(Text(word.wordModel.wordBasicWord ?? "-")),
        DataCell(Text(word.wordModel.wordSplitWord ?? '-')),
        DataCell(Text(word.info?.morphology_process ?? '-')),
        DataCell(Text(word.info?.explanation ?? '-')),
        // DataCell(Text(word.$2.type ?? '-')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => words.length;

  @override
  int get selectedRowCount => 0;
}
