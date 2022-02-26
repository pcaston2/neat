import 'package:neat/neuron.dart';

import 'gene.dart';
import 'neuron.dart';

class Link extends Gene {
  Neuron from;
  Neuron to;
  Link(this.from, this.to);
  get recurrent =>
      from.y >= to.y;
}

class LoopLink extends Link {
  LoopLink(Neuron loop) : super(loop, loop);

}