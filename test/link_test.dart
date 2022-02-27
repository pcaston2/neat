import 'package:test/test.dart';
import 'package:neat/genome.dart';

void main() {
  group('Link', () {
    test('should add', () {
      //Arrange
      Genome g = Genome(1, 1);
      var input = g.inputNeurons.single;
      var output = g.outputNeurons.single;
      //Act
      var link = g.addLink(input, output);
      //Assert
      expect(link.geneIdentifier, equals("(1,2)"));
      expect(link.recurrent, isFalse);
      expect(g.genes, contains(link));
      expect(link.geneDepth, equals(1));
    });

    test('should not detect', () {
      //Arrange
      Genome g = Genome(1, 1);
      var input = g.inputNeurons.single;
      var output = g.outputNeurons.single;
      //Act
      var hasLink = g.hasLink(input, output);
      //Assert
      expect(hasLink, isFalse);
    });

    test('should detect', () {
      //Arrange
      Genome g = Genome(1, 1);
      var input = g.inputNeurons.single;
      var output = g.outputNeurons.single;
      g.addLink(input, output);
      //Act
      var hasLink = g.hasLink(input, output);
      //Assert
      expect(hasLink, isTrue);
    });

    test('should add recurrent', () {
      //Arrange
      Genome g = Genome(1, 1);
      var input = g.inputNeurons.single;
      var output = g.outputNeurons.single;
      //Act
      var recurrentLink = g.addLink(output, input);
      //Assert
      expect(recurrentLink.geneIdentifier, equals("(2,1)"));
      expect(recurrentLink.recurrent, isTrue);
      expect(g.genes, contains(recurrentLink));
      expect(recurrentLink.geneDepth, equals(1));
    });

    test('should add loop', () {
      //Arrange
      Genome g = Genome(0, 1);
      var output = g.outputNeurons.single;
      //Act
      var loopLink = g.addLoopLink(output);
      //Assert
      expect(loopLink.geneIdentifier, equals("(1,1)"));
      expect(g.genes, contains(loopLink));
      expect(loopLink.recurrent, isTrue);
      expect(loopLink.geneDepth, equals(1));
    });

    test('should detect loop', () {
      //Arrange
      Genome g = Genome(0, 1);
      var output = g.outputNeurons.single;
      g.addLoopLink(output);
      //Act
      var hasLink = g.hasLoopLink(output);
      //Assert
      expect(hasLink, isTrue);
    });

    test('should not detect loop', () {
      //Arrange
      Genome g = Genome(0, 1);
      var output = g.outputNeurons.single;
      //Act
      var hasLink = g.hasLoopLink(output);
      //Assert
      expect(hasLink, isFalse);
    });
  });
}