import 'package:json_annotation/json_annotation.dart';
import 'genome.dart';
part 'species.g.dart';

@JsonSerializable(explicitToJson: true)
class Species {
  late List<Genome> genomes;
  Species() {
    genomes = [];
  }

  Species.withRepresentative(Genome representative) {
    genomes = [representative];
  }

  Genome get representative => genomes.first;

  factory Species.fromJson(Map<String, dynamic> json) => _$SpeciesFromJson(json);
  Map<String, dynamic> toJson() => _$SpeciesToJson(this);
}