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
}