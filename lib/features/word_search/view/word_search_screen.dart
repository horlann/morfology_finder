import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:morphology_finder/core/router/router.dart';

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

  void _onWordTap(String word) {
    context.router.push(WordDetailsRoute(word: word));
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
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
                  Expanded(child: _buildSearchResults()),
                ],
              ),
            ),
          ),
        ],
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
          onTap: () => _onWordTap(_searchResults[index]),
        );
      },
    );
  }
}
