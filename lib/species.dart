import 'genome.dart';

class Species {
  late List<Genome> genomes;
  Species() {
    genomes = [];
  }

  Species.withRepresentative(Genome representative) {
    genomes = [representative];
  }

  Genome get representative => genomes.first;

  Genome get fittest => genomes.fold(genomes.first, (fittest, element) => fittest.fitness >= element.fitness ? fittest : element);
}