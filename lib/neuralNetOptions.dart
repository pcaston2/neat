import 'package:json_annotation/json_annotation.dart';
part 'neuralNetOptions.g.dart';

@JsonSerializable(explicitToJson: true)
class NeuralNetOptions {
  num chanceToAddLink;
  num chanceToAddNode;
  num chanceToAddLoop;
  num compatibilityThreshold;
  int sizeOfGeneration;
  num crossOverPercent;

  NeuralNetOptions([
    this.chanceToAddLink = 0.07,
    this.chanceToAddNode = 0.03,
    this.chanceToAddLoop = 0.05,
    this.compatibilityThreshold = 0.26,
    this.sizeOfGeneration = 20,
    this.crossOverPercent = 0.20,
  ]);

  factory NeuralNetOptions.fromJson(Map<String, dynamic> json) => _$NeuralNetOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$NeuralNetOptionsToJson(this);
}