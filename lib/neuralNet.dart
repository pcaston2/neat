import 'package:json_annotation/json_annotation.dart';
import 'package:neat/neuralNetOptions.dart';
import 'package:neat/species.dart';
import 'generation.dart';
import 'species.dart';
import 'genome.dart';
part 'neuralNet.g.dart';

@JsonSerializable(explicitToJson: true)
class NeuralNet {
  int inputs;
  int outputs;
  late NeuralNetOptions options;
  @JsonKey(ignore: true)
  late Map<int, Species> species;
  @JsonKey(ignore: true)
  late Map<int, Generation> generations;

  NeuralNet(this.inputs, this.outputs) {
    options = NeuralNetOptions();
    species = <int, Species>{};
    generations = <int, Generation>{};
  }

  NeuralNet.withOptions(this.inputs, this.outputs, this.options) {
    species = <int, Species>{};
  }

  factory NeuralNet.fromJson(Map<String, dynamic> json) {
    var result = _$NeuralNetFromJson(json);
    Map<int, dynamic> genomes = json['genomes'];
    for(var entry in genomes.entries) {
      var genome = Genome.fromJson(entry.value);
      var speciesId = entry.value['species'];
      var generationId = entry.value['generation'];
      if (result.species.containsKey(speciesId)) {
        result.species[speciesId]?.genomes.add(genome);
      } else {
        result.species[speciesId] = Species.withRepresentative(genome);
      }
      if (result.generations.containsKey(generationId)) {
        result.generations[generationId]?.genomes.add(genome);
      } else {
        var gen = Generation();
        gen.genomes.add(genome);
        result.generations[generationId] = gen;
      }
    }
    return result;
  }

  Generation createNextGeneration() {
    if (generations.isEmpty) {
      var genome = Genome(inputs, outputs);
      var gen = Generation();
      gen.genomes = [ genome ];
      species[0] = Species.withRepresentative(genome);
      generations[0] = gen;
      return gen;
    } else {
      throw new UnimplementedError("There's no code for the second generation yet");
    }
  }

  Map<String, dynamic> toJson() {
    var json = _$NeuralNetToJson(this);
    var genomes = Map<int, dynamic>();
    var genomeIndex = 0;
    for(var entry in species.entries) {
      var species = entry.value;
      for(var g in species.genomes) {
        var speciesId = entry.key;
        var generationId = findGenerationIdentifier(g);
        var genomeJson = g.toJson();
        genomeJson['generation'] = generationId;
        genomeJson['species'] = speciesId;
        genomeJson['representative'] = species.representative == g ? false : true;
        genomes[genomeIndex] = (genomeJson);
        genomeIndex++;
      }
    }
    json['genomes'] = genomes;
    return json;
  }

  int findGenerationIdentifier(Genome g) {
    for(var gen in generations.entries) {
      if (gen.value.genomes.contains(g)) {
        return gen.key;
      }
    }
    throw ArgumentError("The provided genome could not be found in the network's generations");
  }

  int findSpeciesIdentifier(Genome g) {
    for(var s in species.entries) {
      if (s.value.genomes.contains(g)) {
        return s.key;
      }
    }
    throw ArgumentError("The provided genome could not be found in the network's species");
  }
}