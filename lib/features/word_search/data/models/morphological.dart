import 'package:json_annotation/json_annotation.dart';

part 'morphological.g.dart';

@JsonSerializable(explicitToJson: true)
class MorphologicalModel {
  MorphologicalModel({
    required this.morphologicalId,
    required this.morphologicalWordId,
    required this.morphologicalMorphologyProcess,
    required this.morphologicalMeaning,
    required this.morphologicalExplanation,
    required this.morphologicalType,
  });

  @JsonKey(name: 'id')
  final int morphologicalId;

  @JsonKey(name: 'word_id')
  final int morphologicalWordId;

  @JsonKey(name: 'morphology_process')
  final String? morphologicalMorphologyProcess;

  @JsonKey(name: 'meaning')
  final String? morphologicalMeaning;

  @JsonKey(name: 'explanation')
  final String? morphologicalExplanation;

  @JsonKey(name: 'type')
  final String? morphologicalType;

  factory MorphologicalModel.fromJson(Map<String, dynamic> json) {
    return _$MorphologicalModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MorphologicalModelToJson(this);

  @override
  String toString() {
    return 'MorphologicalModel{morphologicalId: $morphologicalId, morphologicalWordId: $morphologicalWordId, morphologicalMorphologyProcess: $morphologicalMorphologyProcess, morphologicalMeaning: $morphologicalMeaning, morphologicalExplanation: $morphologicalExplanation, morphologicalType: $morphologicalType}';
  }


}
