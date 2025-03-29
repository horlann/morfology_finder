import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_worker_example/features/home/view/home_screen.dart';
import 'package:flutter_web_worker_example/features/spreadsheet/bloc/sp_bl.dart';

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
                  padding: EdgeInsets.only(
                    top: 20 + (widget.showBackButton ? 70 : 0),
                    bottom: 20,
                  ),
                  child: Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.75,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 24,
                      ),
                      child: WordTableScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.showBackButton)
            Positioned(
              left: screenHeight * 0.08,
              top: screenHeight * 0.025,
              child: CustomBackButton(),
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
                    headingRowColor: MaterialStateProperty.all(
                        Colors.white), // Header row color
                    dataRowColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
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
                          horizontalMargin: 0,
                          headingRowColor:
                              MaterialStateProperty.all(Colors.white),
                          arrowHeadColor: Colors.black,
                          source: _WordDataTableSource(words),
                          rowsPerPage: 10, // Количество строк на странице
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
