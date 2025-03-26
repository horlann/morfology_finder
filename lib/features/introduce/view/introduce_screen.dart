import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morphology_finder/core/router/router.dart';

@RoutePage()
class IntroduceScreen extends StatelessWidget {
  const IntroduceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade100, Colors.pink.shade100],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Л. М. Полюга',
                style: GoogleFonts.merriweather(
                  fontSize: screenWidth > 600 ? 40 : 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.75,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                    ),
                  ),
                  Text(
                    'СЛОВНИК\nУКРАЇНСЬКИХ\nМОРФЕМ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.oldStandardTt(
                      fontSize: screenWidth > 600 ? 68 : 48,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 3
                        ..color = Colors.black,
                    ),
                  ),
                  Text(
                    'СЛОВНИК\nУКРАЇНСЬКИХ\nМОРФЕМ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.oldStandardTt(
                      fontSize: screenWidth > 600 ? 68 : 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
              ElevatedButton(
                onPressed: () {
                  context.router.push(HomeRoute());
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.02,
                  ),
                  textStyle: TextStyle(
                    fontSize: screenWidth > 600 ? 36 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Натисни, щоб почати'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
