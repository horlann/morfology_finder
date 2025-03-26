// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'morphological.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MorphologicalModel _$MorphologicalModelFromJson(Map<String, dynamic> json) =>
    MorphologicalModel(
      morphologicalId: (json['id'] as num).toInt(),
      morphologicalWordId: (json['word_id'] as num).toInt(),
      morphologicalMorphologyProcess: json['morphology_process'] as String?,
      morphologicalMeaning: json['meaning'] as String?,
      morphologicalExplanation: json['explanation'] as String?,
      morphologicalType: json['type'] as String?,
    );

Map<String, dynamic> _$MorphologicalModelToJson(MorphologicalModel instance) =>
    <String, dynamic>{
      'id': instance.morphologicalId,
      'word_id': instance.morphologicalWordId,
      'morphology_process': instance.morphologicalMorphologyProcess,
      'meaning': instance.morphologicalMeaning,
      'explanation': instance.morphologicalExplanation,
      'type': instance.morphologicalType,
    };
