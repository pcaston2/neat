import 'package:neat/activation.dart';
import 'package:test/test.dart';
import 'package:neat/neuralNet.dart';

void main() {
  group('Neural Net', () {
    test('should have no generations', () {
      //Arrange
      var nn = NeuralNet(0, 1);
      //Assert
      expect(nn.species, isEmpty);
    });

    test('should generate base generation', () {
      //Arrange
      var nn = NeuralNet(0, 1);
      //Act
      nn.createNextGeneration();
      //Assert
      expect(nn.species, isNotEmpty);
    });

    test('should generate second generation', () {
      //Arrange
      var nn = NeuralNet(0, 1);
      nn.createNextGeneration();
      //Act
      nn.createNextGeneration();
      //Assert
    });

    test('should evolve', () {
      //Arrange
      var nn = NeuralNet(0, 1);
      nn.createNextGeneration();
      num currentFitness = 0;
      //Act
      for (int i=0;i<100;i++) {
        for (var g in nn.currentGeneration) {
          num fitness = 0;
          for (int i=0;i<10;i++) {
            var target = i;
            g.update();
            var result = g.getOutputs().toList().single;
            fitness += Activation.gaussian(result - target);
          }
          g.fitness = fitness;
        }
        nn.createNextGeneration();
        if (nn.fittest.fitness > currentFitness) {
          currentFitness = nn.fittest.fitness;
          var fittest = nn.fittest;
          var outputs = <num>[];
          fittest.clear();
          for (int i=0;i<10;i++) {
            fittest.update();
            var result = fittest.getOutputs().toList().single;
            outputs.add(result);
          }

          // print('Generation: $i');
          // print('Fitness: $currentFitness');
          // print('Species Count: ${nn.species.length}');
          // print('Genes: ${nn.species.values.first.genomes.first.genes.length}');
          // print('Outputs: $outputs');
        }
        if (currentFitness > 9) {
          //print('Generation:  $generationId');
          return;
        }
      }
      throw Exception("Unable to evolve in time");
    });
  });
}