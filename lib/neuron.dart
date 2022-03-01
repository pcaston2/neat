import 'gene.dart';
import 'link.dart';
import 'package:json_annotation/json_annotation.dart';
part 'neuron.g.dart';
part 'neuronbias.dart';

abstract class Neuron implements Gene {
  num x = 0;
  num y = 0;

  late bool canLoop;

  @override
  late String identifier;

  @override
  int depth = 0;

  Neuron() {
    identifier = "";
  }

  Neuron.index(int identifier) {
    this.identifier = identifier.toString();
    depth = 0;
  }


}

class InputNeuron extends Neuron {
  InputNeuron(int innovationIdentifier) : super.index(innovationIdentifier) {
    canLoop = false;
  }
}

class OutputNeuron extends Neuron {
  OutputNeuron(int innovationIdentifier) : super.index(innovationIdentifier) {
    canLoop = true;
  }
}

class HiddenNeuron extends Neuron {
  Link link;
  HiddenNeuron(this.link) : super() {
    identifier = "{${link.from.identifier},${link.to.identifier}}";
    depth = link.depth + 1;
    x = (link.from.x + link.to.x) / 2;
    y = (link.from.y + link.to.y) / 2;
    canLoop = true;
  }
}
