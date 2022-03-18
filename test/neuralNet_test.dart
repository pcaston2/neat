import 'package:test/test.dart';
import 'package:neat/neuralNet.dart';

void main() {
  group('Neural Net', () {
    test('should generate base generation', () {
      //Arrange
      var nn = NeuralNet(0, 1);
      //Act
      nn.createNextGeneration();
      //Assert
      expect(nn.generations.length, equals(1));
      expect(nn.generations.values.single.genomes.length, equals(1));
    });

    test('should generate second generation', () {
      //Arrange
      var nn = NeuralNet(0, 1);
      nn.createNextGeneration();
      //Act
      nn.createNextGeneration();
      //Assert
      expect(nn.generations.length, equals(1));
      expect(nn.generations.values.single.genomes.length, equals(1));
    });
  });
}