import 'gene.dart';



abstract class Neuron implements Gene {
  num x = 0;
  num y = 0;
  @override
  late String geneIdentifier;

  Neuron(int geneIdentifier) {
    this.geneIdentifier = geneIdentifier.toString();
  }
}

class BiasNeuron extends Neuron {
  BiasNeuron(int innovationIdentifier) : super(innovationIdentifier);

}

class InputNeuron extends Neuron {
  InputNeuron(int innovationIdentifier) : super(innovationIdentifier);

}

class OutputNeuron extends Neuron {
  OutputNeuron(int innovationIdentifier) : super(innovationIdentifier);

}

class HiddenNeuron extends Neuron {
  HiddenNeuron(int innovationIdentifier) : super(innovationIdentifier);

}
