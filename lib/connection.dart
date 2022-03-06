import 'package:json_annotation/json_annotation.dart';
import 'package:neat/neuron.dart';
import 'gene.dart';
import 'neuron.dart';
import 'dart:math';
part 'loop.dart';
part 'link.dart';
part 'connection.g.dart';

abstract class Connection extends Gene {
  @JsonKey(fromJson: _NeuronFromJson, toJson: _NeuronToJson)
  Neuron from;
  @JsonKey(fromJson: _NeuronFromJson, toJson: _NeuronToJson)
  Neuron to;
  num weight = 1;
  bool enabled = true;

  Connection(this.from, this.to) {
    depth = max(from.depth, to.depth) + 1;
    identifier = "(${from.identifier},${to.identifier})";
  }

  get recurrent =>
      from.y >= to.y;

  static String _NeuronToJson(Neuron neuron) => neuron.identifier;
  static Neuron _NeuronFromJson(String json) => throw UnimplementedError();
}