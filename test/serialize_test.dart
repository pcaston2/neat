import 'package:neat/neuron.dart';
import 'package:test/test.dart';

void main() {
  test('serialize neuron bias', () {
    //Arrange
    var neuronBias = NeuronBias();
    neuronBias.depth = 2;
    neuronBias.identifier = "1";
    //Act
    var json = neuronBias.toJson();
    var restoredNeuronBias = NeuronBias.fromJson(json);
    //Assert
    expect(restoredNeuronBias.identifier, equals("1"));
    expect(restoredNeuronBias.depth, equals(2));
    expect(restoredNeuronBias.canLoop, isFalse);
  });
}