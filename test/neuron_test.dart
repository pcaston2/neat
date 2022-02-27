import 'package:test/test.dart';
import 'package:neat/genome.dart';

void main() {
  group('Neuron', () {
    test('should add neuron', () {
      //Arrange
      Genome g = Genome(1, 1);
      var input = g.inputNeurons.single;
      var output = g.outputNeurons.single;
      var link = g.addLink(input, output);
      //Act
      var neuron = g.addNeuron(link);
      //Assert
      expect(neuron.geneIdentifier, equals("{1,2}"));
      expect(neuron.x, equals(0.75));
      expect(neuron.y, equals(0.5));
      expect(g.genes, contains(neuron));
      expect(neuron.geneDepth, equals(2));
    });

    test('should detect neuron', () {
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

    test('should not detect neuron', () {
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

    test('should add neuron connected to a hidden one', () {
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
      expect(neuron.geneIdentifier, equals("{{1,2},2}"));
      expect(neuron.x, equals(0.625));
      expect(neuron.y, equals(0.75));
      expect(g.genes, contains(neuron));
      expect(neuron.geneDepth, equals(4));
    });
  });
}
