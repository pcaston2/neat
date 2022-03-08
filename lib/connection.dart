import 'package:json_annotation/json_annotation.dart';
import 'package:neat/node.dart';
import 'gene.dart';
import 'node.dart';
import 'dart:math';
part 'loop.dart';
part 'link.dart';
part 'connection.g.dart';

abstract class Connection extends Gene {
  @JsonKey(fromJson: _NeuronFromJson, toJson: _NeuronToJson)
  Node from;
  @JsonKey(fromJson: _NeuronFromJson, toJson: _NeuronToJson)
  Node to;
  num weight = 1;
  bool enabled = true;

  Connection(this.from, this.to) {
    depth = max(from.depth, to.depth) + 1;
    identifier = "(${from.identifier},${to.identifier})";
  }

  get recurrent =>
      from.y >= to.y;

  static String _NeuronToJson(Node neuron) => neuron.identifier;
  static Node _NeuronFromJson(String json) => throw UnimplementedError();
}