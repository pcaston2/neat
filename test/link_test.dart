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
      expect(link.identifier, equals("(1,2)"));
      expect(link.recurrent, isFalse);
      expect(g.genes, contains(link));
      expect(link.depth, equals(1));
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
      expect(recurrentLink.identifier, equals("(2,1)"));
      expect(recurrentLink.recurrent, isTrue);
      expect(g.genes, contains(recurrentLink));
      expect(recurrentLink.depth, equals(1));
    });

    test('should find possible', () {
      //Arrange
      Genome g = Genome(0, 1);
      var bias = g.biasNeuron;
      var output = g.outputNeurons.single;
      //Act
      var possibleLinks = g.possibleLinks;
      //Assert
      expect(possibleLinks, hasLength(1));
      expect(possibleLinks.where((l) => l.from == bias && l.to == output),isNotEmpty);
    });

    test('should not find possible', () {
      //Arrange
      Genome g = Genome(0, 1);
      var bias = g.biasNeuron;
      var output = g.outputNeurons.single;
      g.addLink(bias, output);
      //Act
      var possibleLinks = g.possibleLinks;
      //Assert
      expect(possibleLinks.where((l) => l.from == bias && l.to == output),isEmpty);
    });

    test('should not link to bias or inputs', () {
      //Arrange
      Genome g = Genome(1, 1);
      var bias = g.biasNeuron;
      var output = g.outputNeurons.single;
      var input = g.inputNeurons.single;
      //Act
      var possibleLinks = g.possibleLinks;
      //Assert
      expect(possibleLinks.where((l) => l.from == output && l.to == bias),isEmpty);
      expect(possibleLinks.where((l) => l.from == output && l.to == input), isEmpty);
      expect(possibleLinks.where((l) => l.from == input && l.to == bias), isEmpty);
      expect(possibleLinks.where((l) => l.from == bias && l.to == input), isEmpty);
    });

    group('Loop', () {

      test('should add loop', () {
        //Arrange
        Genome g = Genome(0, 1);
        var output = g.outputNeurons.single;
        //Act
        var loopLink = g.addLoopLink(output);
        //Assert
        expect(loopLink.identifier, equals("(1)"));
        expect(g.genes, contains(loopLink));
        expect(loopLink.recurrent, isTrue);
        expect(loopLink.depth, equals(1));
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

      test('should find possible', () {
        //Arrange
        Genome g = Genome(0, 1);
        var output = g.outputNeurons.single;
        //Act
        var possibleLinks = g.possibleLoopLink;
        //Assert
        expect(possibleLinks, hasLength(1));
        expect(possibleLinks,contains(output));
      });

      test('should find possible', () {
        //Arrange
        Genome g = Genome(0, 1);
        var output = g.outputNeurons.single;
        g.addLoopLink(output);
        //Act
        var possibleLinks = g.possibleLoopLink;
        //Assert
        expect(possibleLinks, isEmpty);
      });

    });

  });
}