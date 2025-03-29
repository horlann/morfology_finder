import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_worker_example/core/router/router.dart';
import 'package:flutter_web_worker_example/features/word_search/bloc/word_bloc.dart';
import 'package:flutter_web_worker_example/features/word_search/data/models/word.dart';

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return BlocProvider(
      create: (context) => WordBloc(),
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
                vertical: 20,
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
                    Builder(builder: (context) {
                      return TextField(
                        controller: _searchController,
                        onChanged: (text) => context
                            .read<WordBloc>()
                            .add(WordTextChangeEvent(text)),
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
                            onPressed: () {},
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    Expanded(
                      child: BlocBuilder<WordBloc, WordState>(
                        builder: (context, state) {
                          if (state is WordLoadedState) {
                            return _List(words: (state).words);
                          } else {
                            return _List(words: []);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _List extends StatefulWidget {
  const _List({
    required this.words,
  });

  final List<WordModel> words;

  @override
  State<_List> createState() => _ListState();
}

class _ListState extends State<_List> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<WordBloc>().add(WordLoadMoreEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.words.isEmpty) {
      return Center(
        child: Text(
          'Немає результатів для вашого запиту.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.words.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            widget.words[index].wordBasicWord ?? "",
            style: const TextStyle(color: Colors.black),
          ),
          onTap: () {
            final word = widget.words[index];
            context.read<WordBloc>().add(WordSelectEvent(word));
            context.router.push(WordDetailsRoute(wordModel: word));
          },
        );
      },
    );
  }
}
