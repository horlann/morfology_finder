import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_web_worker_example/ui/widgets/custom_back_button.dart';
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
                    padding: EdgeInsets.only(
                      left: (screenWidth - tabWidth * 3) / 2,
                      top: 24,
                      right: (screenWidth - tabWidth * 3) / 2,
                      bottom: 0,
                    ),
                    child: SizedBox(
                      height: 72,
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
                                  fontSize: 24,
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
                                  fontSize: 24,
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
                                  fontSize: 24,
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
                    left: screenWidth * 0.08,
                    top: screenHeight * 0.025,
                    child: CustomBackButton(),
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
