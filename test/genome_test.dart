import 'package:test/test.dart';
import 'package:neat/genome.dart';

void main() {
  group('Genome', ()
  {
    test('should be created', () {
      //Arrange
      Genome g = Genome(1, 1);
      var bias = g.biasNeurons.single;
      var input = g.inputNeurons.single;
      var output = g.outputNeurons.single;
      //Assert
      expect(g.genes.length, equals(3));
      expect(bias.x, equals(0));
      expect(bias.y, equals(0));
      expect(input.x, equals(1));
      expect(input.y, equals(0));
      expect(output.x, equals(0.5));
      expect(output.y, equals(1));
      expect(bias.geneIdentifier, equals("0"));
      expect(input.geneIdentifier, equals("1"));
      expect(output.geneIdentifier, equals("2"));
      expect(g.genes, everyElement((gene) => gene.geneDepth == 0));
    });

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
        expect(link.recurrent, equals(false));
        expect(g.genes, contains(link));
        expect(link.geneDepth, equals(1));
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
        expect(recurrentLink.recurrent, equals(true));
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
        expect(loopLink.recurrent, equals(true));
        expect(loopLink.geneDepth, equals(1));
      });

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
  });
}
