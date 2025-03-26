import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_web_worker_example/features/main/view/main_screen.dart';
import 'package:flutter_web_worker_example/features/spreadsheet/view/spreadsheet_screen.dart';
import 'package:flutter_web_worker_example/features/word_search/view/word_search_screen.dart';
import 'package:google_fonts/google_fonts.dart';

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
    print(screenWidth);
    final screenHeight = MediaQuery.sizeOf(context).height;
    print(screenHeight);
    final tabWidth = screenWidth * 0.12;

    return Scaffold(
      extendBody: true,
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: (screenWidth - tabWidth * 3) / 2),
                  child: TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.blue,
                    indicatorWeight: 3,
                    labelPadding: EdgeInsets.zero,
                    tabs: [
                      SizedBox(
                        width: tabWidth,
                        child: Tab(
                          child: Text(
                            'Головна',
                            style: GoogleFonts.robotoMono(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: tabWidth,
                        child: Tab(
                          child: Text(
                            'Пошук',
                            style: GoogleFonts.robotoMono(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: tabWidth,
                        child: Tab(
                          child: Text(
                            'Таблиця',
                            style: GoogleFonts.robotoMono(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 200,
                  top: 4,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withAlpha(100),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        context.router.pushNamed('/');
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.blue,
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
