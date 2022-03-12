import 'package:json_annotation/json_annotation.dart';

import 'genome.dart';
part 'generation.g.dart';

@JsonSerializable(explicitToJson: true)
class Generation {
  late List<Genome> genomes;
  Generation() {
    genomes = [];
  }

  factory Generation.fromJson(Map<String, dynamic> json) => _$GenerationFromJson(json);
  Map<String, dynamic> toJson() => _$GenerationToJson(this);
}