import 'package:neat/neuronInnovation.dart';
import 'package:test/test.dart';
import 'package:neat/phenotype.dart';

void main() {
  test('Create a new phenotype', () {
    Phenotype p = new Phenotype(1,1);
    expect(p.innovations.length, equals(3));

    var bias = p.biasNeurons().single;
    var input = p.inputNeurons().single;
    var output = p.outputNeurons().single;

    expect(bias.x, equals(0));
    expect(bias.y, equals(0));

    expect(input.x, equals(1));
    expect(input.y, equals(0));

    expect(output.x, equals(0.5));
    expect(output.y, equals(1));

    expect(bias.innovationIdentifier, equals("0"));
    expect(input.innovationIdentifier, equals("1"));
    expect(output.innovationIdentifier, equals("2"));
  });
}
