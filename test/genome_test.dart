import 'package:test/test.dart';
import 'package:neat/genome.dart';

void main() {

  group('Genome', ()
  {

    test('should be created', () {
      //Arrange
      Genome g = Genome(1, 1);
      var bias = g.biasNeuron;
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
      expect(bias.identifier, equals("0"));
      expect(input.identifier, equals("1"));
      expect(output.identifier, equals("2"));
      expect(g.genes, everyElement((gene) => gene.depth == 0));
    });

    test('should crossover', () {
      //Arrange
      Genome fit = Genome(1,1);
      var bias = fit.biasNeuron;
      var input = fit.inputNeurons.single;
      var output = fit.outputNeurons.single;
      fit.addLink(input, output);

      Genome weak = Genome(1,1);
      bias = weak.biasNeuron;
      input = weak.inputNeurons.single;
      output = weak.outputNeurons.single;
      weak.addLink(input, output);
      weak.addLink(bias, output);
      //Act
      var child = Genome.crossover(fit, weak);
      //Assert
      var links = child.links;
      input = child.inputNeurons.single;
      output = child.outputNeurons.single;
      //child shouldn't have link from bias to output
      expect(links.where((l) => l.from == bias && l.to == output),isEmpty);
      expect(links.where((l) => l.from == input && l.to == output),isNotEmpty);
    });
  });
}
