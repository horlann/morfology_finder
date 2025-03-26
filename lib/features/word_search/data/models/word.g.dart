// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordModel _$WordModelFromJson(Map<String, dynamic> json) => WordModel(
      wordId: (json['id'] as num).toInt(),
      wordBasicWord: json['basic_word'] as String?,
      wordSplitWord: json['split_word'] as String?,
    );

Map<String, dynamic> _$WordModelToJson(WordModel instance) => <String, dynamic>{
      'id': instance.wordId,
      'basic_word': instance.wordBasicWord,
      'split_word': instance.wordSplitWord,
    };
