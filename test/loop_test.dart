import 'package:neated/genome.dart';
import 'package:test/test.dart';

void main() {
  group('Loop', () {

    test('should add loop', () {
      //Arrange
      Genome g = Genome(0, 1);
      var output = g.outputs.single;
      //Act
      var loopLink = g.addLoop(output);
      //Assert
      expect(loopLink.identifier, equals("(1)"));
      expect(g.genes, contains(loopLink));
      expect(loopLink.recurrent, isTrue);
      expect(loopLink.depth, equals(1));
    });

    test('should detect loop', () {
      //Arrange
      Genome g = Genome(0, 1);
      var output = g.outputs.single;
      g.addLoop(output);
      //Act
      var hasLink = g.hasLoop(output);
      //Assert
      expect(hasLink, isTrue);
    });

    test('should not detect loop', () {
      //Arrange
      Genome g = Genome(0, 1);
      var output = g.outputs.single;
      //Act
      var hasLink = g.hasLoop(output);
      //Assert
      expect(hasLink, isFalse);
    });

    test('should find possible', () {
      //Arrange
      Genome g = Genome(0, 1);
      var output = g.outputs.single;
      var bias = g.bias;
      var link = g.addLink(output, bias);
      var hidden = g.addNode(link);
      //Act
      var possibleLoop = g.possibleLoops;
      //Assert
      expect(possibleLoop, hasLength(1));
      expect(possibleLoop,contains(hidden));
    });

    test('should be able to add loop', () {
      //Arrange
      Genome g = Genome(0, 1);
      var link = g.addLink(g.bias, g.outputs.first);
      g.addNode(link);
      //Act
      var canAddLoops = g.canAddLoop;
      //Assert
      expect(canAddLoops, isTrue);
    });

    test('should not be able to add loop', () {
      //Arrange
      Genome g = Genome(0, 1);
      var output = g.outputs.single;
      g.addLoop(output);
      //Act
      var canAddLoops = g.canAddLoop;
      //Assert
      expect(canAddLoops, isFalse);
    });

  });
}