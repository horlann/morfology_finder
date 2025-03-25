import 'package:json_annotation/json_annotation.dart';

part 'word.g.dart';

@JsonSerializable(explicitToJson: true)
class WordModel {
  WordModel({
    required this.wordId,
    required this.wordBasicWord,
    required this.wordSplitWord,
  });

  @JsonKey(name: 'id')
  final int wordId;

  @JsonKey(name: 'basic_word')
  final String? wordBasicWord;

  @JsonKey(name: 'split_word')
  final String? wordSplitWord;

factory WordModel.fromJson(Map<String, dynamic> json) {
  return _$WordModelFromJson(json);
}

Map<String, dynamic> toJson() => _$WordModelToJson(this);

  @override
  String toString() {
    return 'WordModel{wordId: $wordId, wordBasicWord: $wordBasicWord, wordSplitWord: $wordSplitWord}';
  }
}
