import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_web_worker_example/features/spreadsheet/bloc/sp_bl.dart';
import 'package:flutter_web_worker_example/ui/widgets/custom_back_button.dart';

@RoutePage()
class SpreadsheetScreen extends StatefulWidget {
  final bool showBackButton;

  const SpreadsheetScreen({
    super.key,
    this.showBackButton = false,
  });

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
          if (widget.showBackButton == true)
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.04,
                      top: (72 + 24) + screenHeight * 0.04,
                      right: screenWidth * 0.04,
                      bottom: 0,
                    ),
                    child: Container(
                      width: screenWidth * 0.84,
                      height: screenHeight * 0.72,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                        vertical: screenHeight * 0.04,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 0,
                        ),
                        child: WordTableScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (widget.showBackButton == true)
            Positioned(
              left: screenWidth * 0.08,
              top: screenHeight * 0.025,
              child: CustomBackButton(),
            ),
          if (widget.showBackButton == false)
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.04,
                    ),
                    child: Container(
                      width: screenWidth * 0.84,
                      height: screenHeight * 0.72,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                        vertical: screenHeight * 0.04,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 0,
                        ),
                        child: WordTableScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
        backgroundColor: Colors.white,
        body: BlocBuilder<SpreadshitBloc, SpreadshitState>(
          builder: (context, state) {
            if (state is SpreadshitLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SpreadshitFailureState) {
              return Center(child: Text('Ошибка: ${state.error}'));
            } else if (state is SpreadshitLoadedState) {
              final words = state.words;

              return SingleChildScrollView(
                padding: EdgeInsets.zero,
                controller: _scrollController,
                child: DataTableTheme(
                  data: DataTableThemeData(
                    decoration: BoxDecoration(color: Colors.white),
                    headingRowColor: WidgetStateProperty.all(
                        Colors.white), // Header row color
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
                                color:
                                    Colors.white), // ✅ Ensures no border color
                          ),
                        ),
                        dividerColor: Colors.white,
                        dataTableTheme: DataTableThemeData(
                          headingRowColor:
                              WidgetStateProperty.resolveWith<Color>(
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
                          rowsPerPage: 10,
                          // Количество строк на странице
                          horizontalMargin: 16,
                          headingRowColor:
                              WidgetStateProperty.all(Colors.white),
                          arrowHeadColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }

            return Center(child: Text('Нема даних'));
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
      DataCell(Text(word.info?.morphology_process ?? '-')),
      DataCell(Text(word.info?.explanation ?? '-')),
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
