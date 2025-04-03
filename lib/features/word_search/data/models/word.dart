class WordModel {
  WordModel({
    required this.wordId,
    required this.wordBasicWord,
    required this.wordSplitWord,
  });

  final int wordId;

  final String? wordBasicWord;

  final String? wordSplitWord;

  @override
  String toString() {
    return 'WordModel{wordId: $wordId, '
        'wordBasicWord: $wordBasicWord, '
        'wordSplitWord: $wordSplitWord}';
  }
}
