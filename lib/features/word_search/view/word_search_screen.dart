import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

@RoutePage()
class WordSearchScreen extends StatefulWidget {
  const WordSearchScreen({super.key});

  @override
  State<WordSearchScreen> createState() => _WordSearchScreenState();
}

class _WordSearchScreenState extends State<WordSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<String> _words = [
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

  void _searchWord(String query) {
    final results = _words
        .where((word) => word.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        // Градиент
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 12),
            SizedBox(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.grey.withAlpha(20),
                  child: Center(
                    child: IconButton(
                      icon: Icon(
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
                  child: Text(
                    'Пошук',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
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
          padding: const EdgeInsets.symmetric(
            horizontal: 200,
            vertical: 100,
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
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => _searchWord(_searchController.text),
                  ),
                ),
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _searchResults[index],
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
