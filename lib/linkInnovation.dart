import 'package:neat/neuronInnovation.dart';

import 'innovation.dart';
import 'neuron.dart';

class LinkInnovation extends Innovation {
  NeuronInnovation from;
  NeuronInnovation to;

  LinkInnovation(this.from, this.to);
}

class RecurrentLinkInnovation extends LinkInnovation {
  RecurrentLinkInnovation(NeuronInnovation recurrent) : super(recurrent, recurrent);
}