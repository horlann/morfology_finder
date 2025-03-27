import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_web_worker_example/core/router/router.dart';

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
    final tabWidth = screenWidth * 0.12;

    return AutoTabsRouter(
      routes: [
        MainRoute(),
        WordSearchRoute(),
        SpreadsheetRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          body: Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
            ),
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
                        child: Row(
                          children: [
                            _buildTabItem(
                              label: 'Головна',
                              index: 0,
                              tabsRouter: tabsRouter,
                              width: tabWidth,
                            ),
                            _buildTabItem(
                              label: 'Пошук',
                              index: 1,
                              tabsRouter: tabsRouter,
                              width: tabWidth,
                            ),
                            _buildTabItem(
                              label: 'Таблиця',
                              index: 2,
                              tabsRouter: tabsRouter,
                              width: tabWidth,
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
                  child: child,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabItem({
    required String label,
    required int index,
    required TabsRouter tabsRouter,
    required double width,
  }) {
    final isActive = tabsRouter.activeIndex == index;
    return GestureDetector(
      onTap: () => tabsRouter.setActiveIndex(index),
      child: Container(
        height: 72,
        width: width,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: isActive
              ? const Border(
                  bottom: BorderSide(color: Colors.white, width: 3),
                )
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.blue : Colors.grey[50],
          ),
        ),
      ),
    );
  }
}
