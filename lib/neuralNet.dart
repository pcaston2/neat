import 'package:json_annotation/json_annotation.dart';
import 'genome.dart';
part 'neuralNet.g.dart';

@JsonSerializable(explicitToJson: true)
class NeuralNet {
  int inputs;
  int outputs;
  NeuralNet(this.inputs, this.outputs);

}