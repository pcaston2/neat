import 'package:neat/neuron.dart';
import 'gene.dart';
import 'neuron.dart';
import 'dart:math';

abstract class ALink extends Gene {
  Neuron from;
  Neuron to;
  num weight = 1;
  bool enabled = true;
  ALink(this.from, this.to) {
    depth = max(from.depth, to.depth) + 1;
  }

  get recurrent =>
      from.y >= to.y;
}

class Link extends ALink {
  Link(from, to) : super (from, to);
}

class LoopLink extends Link {
  LoopLink(Neuron loop) : super(loop, loop);
}