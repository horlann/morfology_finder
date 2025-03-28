import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_web_worker_example/features/main/view/main_screen.dart';
import 'package:flutter_web_worker_example/features/spreadsheet/view/spreadsheet_screen.dart';
import 'package:flutter_web_worker_example/features/word_search/view/word_search_screen.dart';

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
    debugPrint(screenWidth.toString());
    final screenHeight = MediaQuery.sizeOf(context).height;
    debugPrint(screenHeight.toString());
    final tabWidth = screenWidth * 0.12;

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
        ),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: (screenWidth - tabWidth * 3) / 2,
                    ),
                    child: SizedBox(
                      height: screenHeight * 0.08,
                      width: tabWidth * 3,
                      child: TabBar(
                        isScrollable: false,
                        indicatorColor: Colors.white,
                        indicatorWeight: 3,
                        labelPadding: EdgeInsets.zero,
                        tabs: [
                          SizedBox(
                            width: tabWidth,
                            child: Tab(
                              child: Text(
                                'Головна',
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: tabWidth,
                            child: Tab(
                              child: Text(
                                'Пошук',
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: tabWidth,
                            child: Tab(
                              child: Text(
                                'Таблиця',
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.12,
                    top: screenHeight * 0.025,
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
                ],
              ),
              Expanded(
                child: const TabBarView(
                  children: [
                    MainScreen(),
                    WordSearchScreen(),
                    SpreadsheetScreen(
                      showBackButton: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
