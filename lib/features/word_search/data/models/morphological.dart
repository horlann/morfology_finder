import 'package:json_annotation/json_annotation.dart';

class MorphologicalModel {
  MorphologicalModel({
    required this.morphologicalId,
    required this.morphologicalWordId,
    required this.morphologicalMorphologyProcess,
    required this.morphologicalMeaning,
    required this.morphologicalExplanation,
    required this.morphologicalType,
  });

  final int morphologicalId;

  final int morphologicalWordId;

  final String? morphologicalMorphologyProcess;

  final String? morphologicalMeaning;

  final String? morphologicalExplanation;

  final String? morphologicalType;

  @override
  String toString() {
    return 'MorphologicalModel{morphologicalId: $morphologicalId, morphologicalWordId: $morphologicalWordId, morphologicalMorphologyProcess: $morphologicalMorphologyProcess, morphologicalMeaning: $morphologicalMeaning, morphologicalExplanation: $morphologicalExplanation, morphologicalType: $morphologicalType}';
  }
}
