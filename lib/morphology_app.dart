import 'package:flutter/material.dart';
import 'package:morphology_finder/core/router/router.dart';

class MorphologyApp extends StatefulWidget {
  const MorphologyApp({super.key});

  @override
  State<MorphologyApp> createState() => _MorphologyAppState();
}

class _MorphologyAppState extends State<MorphologyApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Morphology Finder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      routerConfig: _router.config(),
    );
  }
}
