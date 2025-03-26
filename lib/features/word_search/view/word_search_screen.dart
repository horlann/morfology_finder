import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphology_finder/core/router/router.dart';
import 'package:morphology_finder/features/word_search/bloc/word_bloc.dart';
import 'package:morphology_finder/features/word_search/data/repositories/word_repository.dart';

@RoutePage()
class WordSearchScreen extends StatefulWidget {
  const WordSearchScreen({super.key});

  @override
  State<WordSearchScreen> createState() => _WordSearchScreenState();
}

class _WordSearchScreenState extends State<WordSearchScreen> with RouteAware {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _words = [
    'Сонце',
    'Мрія',
    'Ліс',
    'Книга',
    'Дерево',
    'Річка',
    'Мова',
    'Вишня',
    'Зірка',
    'Гора',
  ];

  List<String> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults = _words;
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return BlocProvider(
      create: (context) => WordBloc(WordRepository()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade100, Colors.pink.shade100],
              ),
            ),
          ),
          title: Row(
            children: [
              const SizedBox(width: 12),
              SizedBox(
                width: 40,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    color: Colors.grey.withAlpha(20),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          context.router.maybePop();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: const Text(
                      'Пошук',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.1,
                vertical: screenHeight * 0.1,
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
                  Expanded(child: _buildSearchResults()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Text(
          'Немає результатів для вашого запиту.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            _searchResults[index],
            style: const TextStyle(color: Colors.black),
          ),
          onTap: () {
            final word = _searchResults[index];
            context.read<WordBloc>().add(WordSelectEvent(word));
            context.router.push(WordDetailsRoute(word: word));
          },
        );
      },
    );
  }
}
