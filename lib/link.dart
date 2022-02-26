import 'package:neat/neuron.dart';

import 'gene.dart';
import 'neuron.dart';

class Link extends Gene {
  Neuron from;
  Neuron to;

  Link(this.from, this.to);
}

class LoopLink extends Link {
  LoopLink(Neuron recurrent) : super(recurrent, recurrent);
}