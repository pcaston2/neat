import 'package:test/test.dart';
import 'package:neat/genome.dart';

void main() {

  group('Genome', ()
  {

    test('should be created', () {
      //Arrange
      Genome g = Genome(1, 1);
      var bias = g.bias;
      var input = g.inputs.single;
      var output = g.outputs.single;
      //Assert
      expect(g.genes.length, equals(3));
      expect(g.generation, equals(0));
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

    test('should be in same species', () {
      //Arrange
      Genome g1 = Genome(1, 1);
      var g2 = Genome.clone(g1);
      //Act
      var isSameSpecies = g1.isSameSpecies(g2);
      //Assert
      expect(isSameSpecies, isTrue);
    });

    test('should be in different species with links', () {
      //Arrange
      Genome g1 = Genome(1, 1);
      var g2 = Genome.clone(g1);
      var bias = g2.bias;
      var output = g2.outputs.first;
      g2.addLink(bias, output);
      //Act
      var isSameSpecies = g1.isSameSpecies(g2);
      //Assert
      expect(isSameSpecies, isFalse);
    });

    test('should be in same species with slightly different weight', () {
      //Arrange
      Genome g1 = Genome(1, 1);
      var bias = g1.bias;
      var output = g1.outputs.first;
      var link = g1.addLink(bias, output);
      var g2 = Genome.clone(g1);
      link.weight = 1.20;
      //Act
      var isSameSpecies = g1.isSameSpecies(g2);
      //Assert
      expect(isSameSpecies, isTrue);
    });

    test('should be in different species with very different weight', () {
      //Arrange
      Genome g1 = Genome(1, 1);
      var bias = g1.bias;
      var output = g1.outputs.first;
      var link = g1.addLink(bias, output);
      var g2 = Genome.clone(g1);
      link.weight = 1.30;
      //Act
      var isSameSpecies = g1.isSameSpecies(g2);
      //Assert
      expect(isSameSpecies, isFalse);
    });

    test('should crossover', () {
      //Arrange
      Genome fit = Genome(1,1);
      var bias = fit.bias;
      var input = fit.inputs.single;
      var output = fit.outputs.single;
      fit.addLink(input, output);

      Genome weak = Genome(1,1);
      bias = weak.bias;
      input = weak.inputs.single;
      output = weak.outputs.single;
      weak.addLink(input, output);
      weak.addLink(bias, output);
      //Act
      var child = Genome.crossover(fit, weak);
      //Assert
      var links = child.links;
      input = child.inputs.single;
      output = child.outputs.single;
      //child shouldn't have link from bias to output
      expect(links.where((l) => l.from == bias && l.to == output),isEmpty);
      expect(links.where((l) => l.from == input && l.to == output),isNotEmpty);
    });
  });
}
