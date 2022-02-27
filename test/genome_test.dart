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



  });
}
