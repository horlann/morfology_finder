import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_worker_example/core/router/router.dart';
import 'package:flutter_web_worker_example/features/home/view/home_screen.dart';
import 'package:flutter_web_worker_example/features/word_details/bloc/word_details_bloc.dart';
import 'package:flutter_web_worker_example/features/word_search/data/models/word.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class WordDetailsScreen extends StatefulWidget {
  const WordDetailsScreen({
    super.key,
    required this.wordModel,
  });

  final WordModel wordModel;

  @override
  State<WordDetailsScreen> createState() => _WordDetailsScreenState();
}

class _WordDetailsScreenState extends State<WordDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return BlocProvider(
      create: (context) =>
          WordDetailsBloc(widget.wordModel)..add(WordDetailsSelectEvent()),
      child: Scaffold(
        body: BlocBuilder<WordDetailsBloc, WordDetailsState>(
            builder: (context, state) {
          if (state is WordDetailsLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WordDetailsFailureState) {
            return Center(child: Text('Ошибка: ${state.exception}'));
          } else if (state is WordDetailsLoadedState) {
            final morphologyProcess = state.wordModel.info?.morphology_process;
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue.shade100, Colors.pink.shade100],
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.12,
                  top: 24 + screenHeight * 0.025,
                  child: CustomBackButton(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.25,
                    vertical: screenHeight * 0.1,
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 40),
                          Text(
                            widget.wordModel.wordSplitWord ??
                                'Цього слова в базі даних немає',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 25),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: (morphologyProcess ?? '').isEmpty
                                        ? 'Морфонологічного пояснення немає'
                                        : '${(morphologyProcess ?? '').split(', ').first})',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: (state.wordModel.info?.explanation ??
                                                '')
                                            .isEmpty
                                        ? ''
                                        : ' - ${(state.wordModel.info?.explanation ?? '').split(';').first}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  if ((morphologyProcess ?? '')
                                          .split(', ')
                                          .length >
                                      1)
                                    TextSpan(
                                      text: (morphologyProcess ?? '').isEmpty
                                          ? ''
                                          : '\n\n(${(morphologyProcess ?? '').split(', ').last}',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  if ((state.wordModel.info?.explanation ?? '')
                                          .split(';')
                                          .length >
                                      1)
                                    TextSpan(
                                      text: (state.wordModel.info
                                                      ?.explanation ??
                                                  '')
                                              .isEmpty
                                          ? ''
                                          : ' - ${(state.wordModel.info?.explanation ?? '').split(';').last}',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  if (state.wordModel.info?.meaning != null &&
                                      state.wordModel.info!.meaning
                                          .isNotEmpty) ...[
                                    TextSpan(
                                      text: '\n\nПояснювальна ремарка - ',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${state.wordModel.info?.meaning.replaceAll('(', '').replaceAll(')', '')}',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.04,
                  left: screenWidth * 0.33,
                  right: screenWidth * 0.33,
                  child: OutlinedButton(
                    onPressed: () {
                      context.router
                          .push(SpreadsheetRoute(showBackButton: true));
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.02,
                      ),
                      side: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Подивитися таблицю всіх слів \nз морфологічними процесами',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: screenWidth > 600 ? 20 : 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
