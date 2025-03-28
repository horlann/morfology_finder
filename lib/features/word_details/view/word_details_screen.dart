import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_web_worker_example/core/db/db.dart';
import 'package:flutter_web_worker_example/core/router/router.dart';
import 'package:flutter_web_worker_example/features/word_search/data/models/word.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class WordDetailsScreen extends StatefulWidget {
  const WordDetailsScreen({
    super.key,
    required this.word,
  });

  final WordModel word;

  @override
  State<WordDetailsScreen> createState() => _WordDetailsScreenState();
}

class _WordDetailsScreenState extends State<WordDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
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
            left: 200,
            top: 20,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 120),
                  Text(
                    widget.word.wordSplitWord ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.04,
            left: screenWidth * 0.33,
            right: screenWidth * 0.33,
            child: OutlinedButton(
              onPressed: () {
                context.router.push(SpreadsheetRoute(showBackButton: true));
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
      ),
    );
  }
}
