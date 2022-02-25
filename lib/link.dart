library neat;

import 'neuron.dart';
import 'innovation.dart';

class Link {
  Neuron from;
  Neuron to;
  num weight;
  bool enabled;
  Innovation innovation;

  bool get recurrent {
    return from == to;
  }

  Link(this.innovation, this.from, this.to, this.weight, this.enabled);
}