import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morphology_finder/features/main/view/main_screen.dart';

import 'package:morphology_finder/features/spreadsheet/view/spreadsheet_screen.dart';
import 'package:morphology_finder/features/word_search/view/word_search_screen.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      extendBody: true,
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Stack(
              children: [
                TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        'Головна',
                        style: GoogleFonts.robotoMono(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Пошук',
                        style: GoogleFonts.robotoMono(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Таблиця',
                        style: GoogleFonts.robotoMono(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 10,
                  top: 8,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context.router.maybePop();
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: const TabBarView(
                children: [
                  MainScreen(),
                  WordSearchScreen(),
                  SpreadsheetScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
