import 'package:neat/neuron.dart';
import 'gene.dart';
import 'neuron.dart';
import 'dart:math';

class Link extends Gene {
  Neuron from;
  Neuron to;
  Link(this.from, this.to) {
    geneDepth = max(from.geneDepth, to.geneDepth) + 1;
  }

  get recurrent =>
      from.y >= to.y;
}

class LoopLink extends Link {
  LoopLink(Neuron loop) : super(loop, loop);
}