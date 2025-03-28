import 'package:json_annotation/json_annotation.dart';

class MorphologicalModel {
  MorphologicalModel({
    required this.morphologicalModelId,
    required this.morphologicalModelWordId,
    required this.morphologicaModellMorphologyProcess,
    required this.morphologicalModelMeaning,
    required this.morphologicalModelExplanation,
    required this.morphologicalModelType,
  });

  final int morphologicalModelId;

  final int morphologicalModelWordId;

  final String? morphologicalModelMorphologyProcess;

  final String? morphologicalModelMeaning;

  final String? morphologicalModelExplanation;

  final String? morphologicalModelType;

  @override
  String toString() {
    return 'MorphologicalModel{morphologicalId: $morphologicalModelId, morphologicalWordId: $morphologicalModelWordId, morphologicalMorphologyProcess: $morphologicaModellMorphologyProcess, morphologicalMeaning: $morphologicalModelMeaning, morphologicalExplanation: $morphologicalModelExplanation, morphologicalType: $morphologicalModelType}';
  }
}
