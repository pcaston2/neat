import 'package:test/test.dart';
import 'package:neated/genome.dart';

void main() {
  group('Link', () {
    test('should add', () {
      //Arrange
      Genome g = Genome(1, 1);
      var input = g.inputs.single;
      var output = g.outputs.single;
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
      var input = g.inputs.single;
      var output = g.outputs.single;
      //Act
      var hasLink = g.hasLink(input, output);
      //Assert
      expect(hasLink, isFalse);
    });

    test('should detect', () {
      //Arrange
      Genome g = Genome(1, 1);
      var input = g.inputs.single;
      var output = g.outputs.single;
      g.addLink(input, output);
      //Act
      var hasLink = g.hasLink(input, output);
      //Assert
      expect(hasLink, isTrue);
    });

    test('should add recurrent', () {
      //Arrange
      Genome g = Genome(1, 1);
      var input = g.inputs.single;
      var output = g.outputs.single;
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
      var bias = g.bias;
      var output = g.outputs.single;
      //Act
      var possibleLinks = g.possibleLinks;
      //Assert
      expect(possibleLinks, hasLength(1));
      expect(possibleLinks.where((l) => l.from == bias && l.to == output),isNotEmpty);
    });

    test('should not find possible', () {
      //Arrange
      Genome g = Genome(0, 1);
      var bias = g.bias;
      var output = g.outputs.single;
      g.addLink(bias, output);
      //Act
      var possibleLinks = g.possibleLinks;
      //Assert
      expect(possibleLinks.where((l) => l.from == bias && l.to == output),isEmpty);
    });

    test('should be able to add link', () {
      //Arrange
      Genome g = Genome(0, 1);
      //Act
      var canAddLinks = g.canAddLink;
      //Assert
      expect(canAddLinks, isTrue);
    });

    test('should not be able to add link', () {
      //Arrange
      Genome g = Genome(0, 1);
      var bias = g.bias;
      var output = g.outputs.single;
      g.addLink(bias, output);
      //Act
      var canAddLinks = g.canAddLink;
      //Assert
      expect(canAddLinks, isFalse);
    });

    test('should not link to bias or inputs', () {
      //Arrange
      Genome g = Genome(1, 1);
      var bias = g.bias;
      var output = g.outputs.single;
      var input = g.inputs.single;
      //Act
      var possibleLinks = g.possibleLinks;
      //Assert
      expect(possibleLinks.where((l) => l.from == output && l.to == bias),isEmpty);
      expect(possibleLinks.where((l) => l.from == output && l.to == input), isEmpty);
      expect(possibleLinks.where((l) => l.from == input && l.to == bias), isEmpty);
      expect(possibleLinks.where((l) => l.from == bias && l.to == input), isEmpty);
    });



  });
}