import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_worker_example/core/router/router.dart';
import 'package:flutter_web_worker_example/features/word_search/bloc/word_bloc.dart';
import 'package:flutter_web_worker_example/features/word_search/data/models/word.dart';
import 'package:flutter_web_worker_example/features/word_search/data/repositories/word_repository.dart';

@RoutePage()
class WordSearchScreen extends StatefulWidget {
  const WordSearchScreen({super.key});

  @override
  State<WordSearchScreen> createState() => _WordSearchScreenState();
}

class _WordSearchScreenState extends State<WordSearchScreen> with RouteAware {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchWord(String query) {
    final results = _words
        .where((word) => word.toLowerCase().contains(query.toLowerCase()))
        .take(5)
        .toList();

    setState(() {
      _searchResults = results;
    });
  }

  void _onWordTap(String word) {
    context.router.push(WordDetailsRoute(word: word));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return BlocProvider(
      create: (context) => WordBloc(WordRepository()),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade100, Colors.pink.shade100],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.25,
                vertical: screenHeight * 0.1,
              ),
              child: Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.8,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: _searchWord,
                      decoration: InputDecoration(
                        labelText: 'Пошук слова',
                        labelStyle: TextStyle(
                          color: Colors.black.withAlpha(100),
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () => _searchWord(_searchController.text),
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: BlocBuilder<WordBloc, WordState>(
                        builder: (context, state) {
                          if (state is WordLoadedState) {
                            return _buildSearchResults((state).words);
                          } else {
                            return _buildSearchResults([]);
                          }
                        },
                      ),
                    ),                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(List<WordModel> words) {
    if (words.isEmpty) {
      return Center(
        child: Text(
          'Немає результатів для вашого запиту.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      );
    }

    return ListView.builder(
      itemCount: words.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            words[index].wordBasicWord ?? "",
            style: const TextStyle(color: Colors.black),
          ),
          onTap: () {
            final word = words[index];
            context.read<WordBloc>().add(WordSelectEvent(word));
            context.router
                .push(WordDetailsRoute(word: word.wordBasicWord ?? ''));
          },
        );
      },
    );
  }
}
