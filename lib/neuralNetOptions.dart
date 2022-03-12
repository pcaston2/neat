import 'package:json_annotation/json_annotation.dart';
part 'neuralNetOptions.g.dart';

@JsonSerializable(explicitToJson: true)
class NeuralNetOptions {
  num chanceToAddLink;
  num chanceToAddNode;
  num chanceToAddLoop;
  num compatibilityThreshold;

  NeuralNetOptions([
    this.chanceToAddLink = 0.07,
    this.chanceToAddNode = 0.03,
    this.chanceToAddLoop = 0.05,
    this.compatibilityThreshold = 2.6,
  ]);

  factory NeuralNetOptions.fromJson(Map<String, dynamic> json) => _$NeuralNetOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$NeuralNetOptionsToJson(this);
}