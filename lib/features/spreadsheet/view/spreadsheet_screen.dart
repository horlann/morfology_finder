import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_worker_example/core/db/db.dart';
import 'package:flutter_web_worker_example/features/spreadsheet/bloc/sp_bl.dart';
import 'package:flutter_web_worker_example/features/word_search/data/models/word.dart';

@RoutePage()
class SpreadsheetScreen extends StatefulWidget {
  final bool showBackButton;

  const SpreadsheetScreen({super.key, this.showBackButton = false});

  @override
  State<SpreadsheetScreen> createState() => _SpreadsheetScreenState();
}

class _SpreadsheetScreenState extends State<SpreadsheetScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade100, Colors.pink.shade100],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    top: 20,
                    right: 40,
                    bottom: 20,
                  ),
                  child: IntrinsicHeight(
                    child: Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.8,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: WordTableScreen(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.showBackButton)
            Positioned(
              top: 24,
              left: 24,
              child: GestureDetector(
                onTap: () {
                  context.router.maybePop();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class WordTableScreen extends StatefulWidget {
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
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      //context.read<SpreadshitBloc>().add(WordLoadMoreEvent()); // Подгрузка следующей страницы
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SpreadshitBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text('Список слов')),
        body: BlocBuilder<SpreadshitBloc, SpreadshitState>(
          builder: (context, state) {
            if (state is SpreadshitLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SpreadshitFailureState) {
              return Center(child: Text('Ошибка: ${state.error}'));
            } else if (state is SpreadshitLoadedState) {
              final words = state.words;

              return SingleChildScrollView(
                controller: _scrollController,
                child: PaginatedDataTable(
                  header: Text('Таблица слов'),
                  columns: [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Word ID')),
                    DataColumn(label: Text('Morphology Process')),
                    DataColumn(label: Text('Meaning')),
                    DataColumn(label: Text('Explanation')),
                    // DataColumn(label: Text('Type')),
                  ],
                  source: _WordDataTableSource(words),
                  rowsPerPage: 10, // Количество строк на странице
                ),
              );
            }

            return Center(child: Text('Нет данных'));
          },
        ),
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
  final List<AggregatedWordModel> words;

  _WordDataTableSource(this.words);

  @override
  DataRow getRow(int index) {
    if (index >= words.length) return null!;
    final word = words[index];

    return DataRow(cells: [
      DataCell(Text(word.wordModel.wordId.toString())),
      DataCell(Text(word.wordModel.wordBasicWord ?? "-")),
      DataCell(Text(word.wordModel.wordSplitWord ?? '-')),
      DataCell(Text(word.info.morphology_process ?? '-')),
      DataCell(Text(word.info.explanation ?? '-')),
      // DataCell(Text(word.$2.type ?? '-')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => words.length;

  @override
  int get selectedRowCount => 0;
}
