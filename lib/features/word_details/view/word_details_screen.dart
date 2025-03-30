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
              // handling morphologyProcess
              final morphologyProcess =
                  state.wordModel.info?.morphology_process;
              final morphologyProcessNew = (morphologyProcess != null &&
                      morphologyProcess.length > 2)
                  ? morphologyProcess.substring(1, morphologyProcess.length - 1)
                  : null;
              List<String> firstPart = morphologyProcessNew?.split(", ") ?? [];

              // handling explanation
              final explanation = state.wordModel.info?.explanation;
              List<String> secondPart = explanation?.split(";") ?? [];

              // handling meaning
              final meaning = state.wordModel.info?.meaning;
              final meaningNew = (meaning != null &&
                      meaning.startsWith('(') &&
                      meaning.endsWith(')'))
                  ? meaning.substring(1, meaning.length - 1)
                  : meaning;
              final thirdPart = meaningNew;

              // handling TextRich
              List<TextSpan> textSpans = [];
              for (int i = 0;
                  i < firstPart.length && i < secondPart.length;
                  i++) {
                textSpans.add(
                  TextSpan(
                    text: '(${firstPart[i]}) ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                );

                textSpans.add(
                  TextSpan(
                    text: '- ${secondPart[i]}\n',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                );
                textSpans.add(TextSpan(text: '\n'));
              }
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
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    if (firstPart.isNotEmpty) ...textSpans,
                                    if (firstPart.isEmpty)
                                      TextSpan(
                                        text:
                                            "Морфонологічного пояснення немає",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    if (thirdPart != null &&
                                        thirdPart.isNotEmpty) ...[
                                      TextSpan(
                                        text: '\nПояснювальна ремарка - ',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: thirdPart,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
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
          },
        ),
      ),
    );
  }
}
