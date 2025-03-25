import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:auto_route/auto_route.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  fontSize: 40,
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
                      width: 540,
                      height: 800,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                    ),
                  ),
                  Text(
                    'СЛОВНИК\nУКРАЇНСЬКИХ\nМОРФЕМ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.oldStandardTt(
                      fontSize: 72,
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
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 200),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 24,
                  ),
                  textStyle: TextStyle(fontSize: 36,
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
