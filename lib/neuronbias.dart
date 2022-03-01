part of 'neuron.dart';

@JsonSerializable()

class NeuronBias extends Neuron {

  NeuronBias() {
    canLoop = false;
  }

  NeuronBias.index(int innovationIdentifier) : super.index(innovationIdentifier) {
    canLoop = false;
  }

  factory NeuronBias.fromJson(Map<String, dynamic> json) => _$NeuronBiasFromJson(json);

  Map<String, dynamic> toJson() => _$NeuronBiasToJson(this);
}