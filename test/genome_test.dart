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
      });

      test('should add recurrent', () {
        //Arrange
        Genome g = Genome(1, 1);
        var input = g.inputNeurons.single;
        var output = g.outputNeurons.single;
        //Act
        var link = g.addLink(output, input);
        //Assert
        expect(link.geneIdentifier, equals("(2,1)"));
        expect(link.recurrent, equals(true));
        expect(g.genes, contains(link));
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
      });
    });
  });
}
