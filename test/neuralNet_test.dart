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

    test('should generate 20 generations', () {
      //Arrange
      var nn = NeuralNet(0, 1);
      //Act
      for (int i=0;i<20;i++) {
        nn.createNextGeneration();
      }
      //Assert
    });
  });
}