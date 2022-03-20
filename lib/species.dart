import 'package:json_annotation/json_annotation.dart';
import 'genome.dart';
part 'species.g.dart';

@JsonSerializable(explicitToJson: true)
class Species {
  late Genome representative;
  late List<Genome> genomes;

  Species(this.representative) {
    genomes = [];
  }

  Genome get fittest => genomes.fold(genomes.first, (fittest, element) => fittest.fitness >= element.fitness ? fittest : element);

  void add(Genome g) {
    genomes.add(g);
  }

  factory Species.fromJson(Map<String, dynamic> json) => _$SpeciesFromJson(json);

  void clear() {
    genomes.clear();
  }

  Map<String, dynamic> toJson() {
    var result = _$SpeciesToJson(this);
    return result;
  }
}