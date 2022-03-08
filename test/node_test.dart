import 'package:test/test.dart';
import 'package:neat/genome.dart';

void main() {
  group('Neuron', () {
    test('should add', () {
      //Arrange
      Genome g = Genome(1, 1);
      var input = g.inputNeurons.single;
      var output = g.outputNeurons.single;
      var link = g.addLink(input, output);
      //Act
      var neuron = g.addNeuron(link);
      //Assert
      expect(neuron.identifier, equals("{1,2}"));
      expect(neuron.x, equals(0.75));
      expect(neuron.y, equals(0.5));
      expect(g.genes, contains(neuron));
      expect(neuron.depth, equals(1));
    });

    test('should add and include links', () {
      //Arrange
      Genome g = Genome(1, 1);
      var input = g.inputNeurons.single;
      var output = g.outputNeurons.single;
      var link = g.addLink(input, output);
      link.weight = 0.8;
      //Act
      g.addNeuronWithLinks(link);
      //Assert
      expect(link.enabled, isFalse);
      var links = g.links.where((l) => l.enabled);
      var fromLink = links.where((l) => l.from == input).single;
      expect(fromLink.weight, equals(1));
      expect(fromLink.enabled, isTrue);
      var toLink = links.where((l) => l.to == output).single;
      expect(toLink.weight, equals(0.8));
      expect(toLink.enabled, isTrue);
    });

    test('should detect', () {
      //Arrange
      Genome g = Genome(1, 1);
      var input = g.inputNeurons.single;
      var output = g.outputNeurons.single;
      var link = g.addLink(input, output);
      g.addNeuron(link);
      //Act
      var hasNeuron = g.hasNeuron(link);
      //Assert
      expect(hasNeuron, isTrue);
    });

    test('should not detect', () {
      //Arrange
      Genome g = Genome(1, 1);
      var input = g.inputNeurons.single;
      var output = g.outputNeurons.single;
      var link = g.addLink(input, output);
      //Act
      var hasNeuron = g.hasNeuron(link);
      //Assert
      expect(hasNeuron, isFalse);
    });

    test('should add with connected to a hidden one', () {
      //Arrange
      Genome g = Genome(1, 1);
      var input = g.inputNeurons.single;
      var output = g.outputNeurons.single;
      var link = g.addLink(input, output);
      var firstNeuron = g.addNeuron(link);
      var secondLink = g.addLink(firstNeuron, output);
      //Act
      var neuron = g.addNeuron(secondLink);
      //Assert
      expect(neuron.identifier, equals("{{1,2},2}"));
      expect(neuron.x, equals(0.625));
      expect(neuron.y, equals(0.75));
      expect(g.genes, contains(neuron));
      expect(neuron.depth, equals(2));
    });

    test('should find possible neurons', () {
      //Arrange
      Genome g = Genome(1,1);
      var input = g.inputNeurons.single;
      var output = g.outputNeurons.single;
      var link = g.addLink(input, output);
      //Act
      var possibleNeurons = g.possibleNeurons;
      //Assert
      expect(possibleNeurons.length, 1);
      expect(possibleNeurons, contains(link));
    });

    test('should not be able to add neurons', () {
      //Arrange
      Genome g = Genome(1,1);
      //Act
      var canAddNeurons = g.canAddNeuron;
      //Assert
      expect(canAddNeurons, isFalse);
    });

    test('should be able to add neurons', () {
      //Arrange
      Genome g = Genome(1,1);
      var input = g.inputNeurons.single;
      var output = g.outputNeurons.single;
      g.addLink(input, output);
      //Act
      var canAddNeurons = g.canAddNeuron;
      //Assert
      expect(canAddNeurons, isTrue);
    });
  });
}
