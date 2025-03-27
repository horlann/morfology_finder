import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade100, Colors.pink.shade100],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    top: 20,
                    right: 40,
                    bottom: 20,
                  ),
                  child: IntrinsicHeight(
                    child: Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.8,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '''\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\Сучасна '''
                              '''українська лексикографія, '''
                              '''відповідаючи вимогам інформаційного суспільства, '''
                              '''характеризується тенденцією цифрового представлення '''
                              '''лексикографічних даних. Керуючись актуальними '''
                              '''завданнями й методами комп'ютерної лінгвістики у '''
                              '''галузі словникарства, студент-бакалавр 4-го курсу '''
                              '''Ярох Анна досліджує морфонологічні процеси в '''
                              ''''"Словнику українських морфем" Л.М. Полюги. Вона '''
                              '''також працює над проєктом його електронної версії, '''
                              '''що сприятиме подальшому розвитку цифрової лексикографії.''',
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                height: 2,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              textAlign: TextAlign.justify,
                              strutStyle: const StrutStyle(
                                forceStrutHeight: true,
                                height: 2.5,
                              ),
                            ),
                            Text(
                              '''\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\Важливість '''
                              '''цієї проблеми полягає у необхідності оптимізації '''
                              '''обробки та аналізу мовних даних, що сприятиме '''
                              '''підвищенню ефективності досліджень та розширенню '''
                              '''можливостей користувачів. Складність конвертації '''
                              '''традиційних морфемних словників, таких як '''
                              '''"Морфемний аналіз" Яценка І.Т. та '''
                              ''''"Словник українських морфем" Л.М. Полюги, '''
                              '''обумовлена спеціальним способом подання морфемної '''
                              '''структури слів. Через це актуальним є розроблення '''
                              '''методики й програмного забезпечення для автоматичної '''
                              '''конверсії "Словника українських морфем" у цифровий формат.''',
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                height: 2,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              textAlign: TextAlign.justify,
                              strutStyle: const StrutStyle(
                                forceStrutHeight: true,
                                height: 2.5,
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0Мета дослідження ',
                                    style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      height: 2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'полягає у створенні електронної версії "Словника українських морфем" '
                                        'Л.М. Полюги з акцентом на морфонологічні процеси.',
                                    style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      height: 2,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.justify,
                              strutStyle: const StrutStyle(
                                forceStrutHeight: true,
                                height: 2.5,
                              ),
                            ),
                            Text(
                              '''\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\Завдання дослідження: ''',
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                height: 2,
                                fontWeight: FontWeight.bold,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              textAlign: TextAlign.justify,
                              strutStyle: const StrutStyle(
                                forceStrutHeight: true,
                                height: 2.5,
                              ),
                            ),
                            Text(
                              '''\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\➢ '''
                              '''дослідити історію розвитку комп’ютерної лексикографії; ''',
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                height: 2,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              textAlign: TextAlign.justify,
                              strutStyle: const StrutStyle(
                                forceStrutHeight: true,
                                height: 2.5,
                              ),
                            ),
                            Text(
                              '''\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\➢ '''
                              '''визначити актуальність комп’ютерної лексикографії, описати її завдання та проблеми;''',
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                height: 2,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              textAlign: TextAlign.justify,
                              strutStyle: const StrutStyle(
                                forceStrutHeight: true,
                                height: 2.5,
                              ),
                            ),
                            Text(
                              '''\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\➢ '''
                              '''розробити концепції інфологічної та даталогічної моделі лексикографічної бази даних;''',
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                height: 2,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              textAlign: TextAlign.justify,
                              strutStyle: const StrutStyle(
                                forceStrutHeight: true,
                                height: 2,
                              ),
                            ),
                            Text(
                              '''\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\➢ '''
                              '''описати призначення словника та вихідні дані для його розробки;''',
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                height: 2,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              textAlign: TextAlign.justify,
                              strutStyle: const StrutStyle(
                                forceStrutHeight: true,
                                height: 2.5,
                              ),
                            ),
                            Text(
                              '''\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\➢ '''
                              '''обрати програмний інструментарій для конвертації словника;''',
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                height: 2,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              textAlign: TextAlign.justify,
                              strutStyle: const StrutStyle(
                                forceStrutHeight: true,
                                height: 2.5,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
