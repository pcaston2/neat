import 'package:json_annotation/json_annotation.dart';
import 'package:neat/neuralNetOptions.dart';
import 'package:neat/species.dart';
import 'package:neat/weightedRandomChoice.dart';
import 'species.dart';
import 'genome.dart';
part 'neuralNet.g.dart';

@JsonSerializable(explicitToJson: true)
class NeuralNet {
  int inputs;
  int outputs;
  late NeuralNetOptions options;
  late Map<int, Species> species;

  NeuralNet(this.inputs, this.outputs) {
    options = NeuralNetOptions();
    species = <int, Species>{};
  }

  NeuralNet.withOptions(this.inputs, this.outputs, this.options) {
    species = <int, Species>{};
  }

  List<Genome> get currentGeneration {
    var generation = <Genome>[];
    for (var s in species.entries) {
      for (var g in s.value.genomes) {
        generation.add(g);
      }
    }
    return generation;
  }

  Genome get fittest {
    Genome fittest = species.entries.first.value.fittest;
    for (var s in species.entries) {
      if (s.value.fittest.fitness > fittest.fitness) {
        fittest = s.value.fittest;
      }
    }
    return fittest;
  }

  void createNextGeneration() {
    if (species.isEmpty) {
      var progenitor = Genome(inputs, outputs);
      for (int i=0;i<options.sizeOfGeneration;i++) {
        var child = Genome.mutate(progenitor);
        add(child);
      }
    } else {
      Map<Genome, num> fitMap = <Genome, num>{};
      for(var s in species.entries) {
        var fittest = s.value.fittest;
        fitMap[fittest] = fittest.fitness;
        s.value.clear();
      }
      var fittest = fitMap.keys.fold<Genome>(
          fitMap.keys.first,
          (previousValue, element) => previousValue.fitness >= element.fitness ? previousValue : element
      );
      add(fittest);
      int length = 1;
      for (int i=0;i<(options.sizeOfGeneration * options.crossOverPercent).round(); i++) {
        var firstChosen = fitMap.weightedChoice();
        var remaining = Map<Genome, num>.from(fitMap);
        remaining.removeWhere((key, value) => key == firstChosen);
        var secondChosen = fitMap.weightedChoice();
        var child = Genome.mutate(Genome.crossover(firstChosen, secondChosen));
        add(child);
        length++;
      }
      for (int i=length;i<options.sizeOfGeneration;i++) {
        var chosen = fitMap.weightedChoice();
        var child = Genome.mutate(chosen);
        add(child);
      }
      species.removeWhere((key, value) => value.genomes.isEmpty);
    }
  }

  void add(Genome g) {
    var species = findCompatibleSpecies(g);
    species.add(g);
  }

  Species findCompatibleSpecies(Genome g) {
    var maxSpeciesId = 0;
    for(var s in species.entries) {
      if (s.key > maxSpeciesId) {
        maxSpeciesId = s.key;
        if (s.value.representative.isSameSpecies(g)) {
          return s.value;
        }
      }
    }
    var newSpecies = Species(g);
    species[++maxSpeciesId] = newSpecies;
    return newSpecies;
  }

  factory NeuralNet.fromJson(Map<String, dynamic> json) => _$NeuralNetFromJson(json);

  Map<String, dynamic> toJson() {
    var result = _$NeuralNetToJson(this);
    return result;
  }
}