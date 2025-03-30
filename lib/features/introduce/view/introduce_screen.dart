import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_web_worker_example/core/router/router.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  fontSize: screenWidth > 600 ? 36 : 26,
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
                      width: screenWidth * 0.3,
                      height: screenHeight * 0.65,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                    ),
                  ),
                  // Text(
                  //   'СЛОВНИК\nУКРАЇНСЬКИХ\nМОРФЕМ',
                  //   textAlign: TextAlign.center,
                  //   style: GoogleFonts.playfairDisplay(
                  //       fontSize: screenWidth > 600 ? 70 : 50,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white),
                  // ),
                  // Text(
                  //   'СЛОВНИК\nУКРАЇНСЬКИХ\nМОРФЕМ',
                  //   textAlign: TextAlign.center,
                  //   style: GoogleFonts.playfairDisplay(
                  //     fontSize: screenWidth > 600 ? 70 : 50,
                  //     fontWeight: FontWeight.bold,
                  //     foreground: Paint()
                  //       ..style = PaintingStyle.stroke
                  //       ..strokeWidth = 3
                  //       ..color = Colors.black, // Border color
                  //     shadows: [
                  //       Shadow(
                  //         offset: Offset(4.0, 3.0), // X and Y offset
                  //         blurRadius: 0.0, // Blur effect
                  //         color: Colors.black, // Shadow color
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Text(
                    'СЛОВНИК\nУКРАЇНСЬКИХ\nМОРФЕМ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 70, // Adjust size based on screen width
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 5
                        ..color = Colors.black, // Border color
                    ),
                  ),
                  // Main filled text
                  Text(
                    'СЛОВНИК\nУКРАЇНСЬКИХ\nМОРФЕМ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 70, // Adjust size based on screen width
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Main text color
                      shadows: [
                        Shadow(
                          offset: Offset(4.0, 3.0), // X and Y offset
                          blurRadius: 0.0, // Blur effect
                          color: Colors.black, // Shadow color
                        ),
                      ],
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
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.02,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: SizedBox(
                  width: screenWidth * 0.2,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Натисни,щоб почати',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: screenWidth > 600 ? 20 : 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
