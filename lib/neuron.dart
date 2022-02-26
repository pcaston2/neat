import 'gene.dart';
import 'link.dart';



abstract class Neuron implements Gene {
  num x = 0;
  num y = 0;
  @override
  late String geneIdentifier;

  Neuron() {
    geneIdentifier = "";
  }

  Neuron.index(int geneIdentifier) {
    this.geneIdentifier = geneIdentifier.toString();
  }
}

class BiasNeuron extends Neuron {
  BiasNeuron(int innovationIdentifier) : super.index(innovationIdentifier);

}

class InputNeuron extends Neuron {
  InputNeuron(int innovationIdentifier) : super.index(innovationIdentifier);

}

class OutputNeuron extends Neuron {
  OutputNeuron(int innovationIdentifier) : super.index(innovationIdentifier);

}

class HiddenNeuron extends Neuron {
  HiddenNeuron(Link link) : super() {
    geneIdentifier = "{${link.from.geneIdentifier},${link.to.geneIdentifier}}";
    x = (link.from.x + link.to.x) / 2;
    y = (link.from.y + link.to.y) / 2;
  }
}
