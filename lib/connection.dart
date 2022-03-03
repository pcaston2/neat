import 'package:neat/neuron.dart';
import 'gene.dart';
import 'neuron.dart';
import 'dart:math';
part 'loop.dart';
part 'link.dart';
//part 'connection.g.dart';

abstract class Connection extends Gene {
  Neuron from;
  Neuron to;
  num weight = 1;
  bool enabled = true;
  Connection(this.from, this.to) {
    depth = max(from.depth, to.depth) + 1;
  }

  get recurrent =>
      from.y >= to.y;
}