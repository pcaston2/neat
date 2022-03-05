import 'package:neat/genome.dart';
import 'package:neat/neuron.dart';
import 'package:neat/connection.dart';
import 'package:test/test.dart';

void main() {
  test('simple genome', () {
    //Arrange
    var g = Genome(1,1);
    g.addLink(g.biasNeuron, g.outputNeurons.single);
    //Act
    var json = g.toJson();
    json.toString();
    g = Genome.fromJson(json);
    //Assert
    var link = g.links.single;
    expect(link.identifier, equals('(0,2)'));
  });

  test('bias', () {
    //Arrange
    var bias = Bias();
    bias.depth = 2;
    //Act
    var json = bias.toJson();
    bias = Bias.fromJson(json);
    //Assert
    expect(bias.identifier, equals("0"));
    expect(bias.depth, equals(2));
    expect(bias.canLoop, isFalse);
    expect(json['type'], equals('Bias'));
  });

  test('input', () {
    //Arrange
    var input = Input.index(2);
    input.depth = 2;
    //Act
    var json = input.toJson();
    input = Input.fromJson(json);
    //Assert
    expect(input.identifier, equals("2"));
    expect(input.depth, equals(2));
    expect(input.canLoop, isFalse);
    expect(json['type'], equals('Input'));
  });


  test('output', () {
    //Arrange
    var output = Output.index(3);
    output.depth = 4;
    //Act
    var json = output.toJson();
    output = Output.fromJson(json);
    //Assert
    expect(output.identifier, equals("3"));
    expect(output.depth, equals(4));
    expect(output.canLoop, isTrue);
    expect(json['type'], equals('Output'));
  });

  test('hidden', () {
    //Arrange
    var link = Link(Bias.index(0), Output.index(1));
    var hidden = Hidden(link);
    hidden.depth = 4;
    //Act
    var json = hidden.toJson();
    hidden = Hidden.fromJson(json);
    //Assert
    expect(hidden.identifier, equals("3"));
    expect(hidden.depth, equals(4));
    expect(hidden.canLoop, isTrue);
    expect(json['type'], equals('Output'));
  });
}