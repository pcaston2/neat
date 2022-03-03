import 'package:json_annotation/json_annotation.dart';

import 'neuron.dart';

class CustomNeuronConverter implements JsonConverter<Neuron, String> {
  const CustomNeuronConverter();

  @override
  Neuron fromJson(String json) {
    return Bias();
  }

  @override
  String toJson(Neuron neuron) => "";
}