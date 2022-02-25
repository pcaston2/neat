import 'innovation.dart';
import 'neuron.dart';


abstract class NeuronInnovation implements Innovation {
  num x = 0;
  num y = 0;
  @override
  late String innovationIdentifier;

  NeuronInnovation(int innovationIdentifier) {
    this.innovationIdentifier = innovationIdentifier.toString();
  }
}

class BiasNeuronInnovation extends NeuronInnovation {
  BiasNeuronInnovation(int innovationIdentifier) : super(innovationIdentifier);

}

class InputNeuronInnovation extends NeuronInnovation {
  InputNeuronInnovation(int innovationIdentifier) : super(innovationIdentifier);

}

class OutputNeuronInnovation extends NeuronInnovation {
  OutputNeuronInnovation(int innovationIdentifier) : super(innovationIdentifier);

}

class HiddenNeuronInnovation extends NeuronInnovation {
  HiddenNeuronInnovation(int innovationIdentifier) : super(innovationIdentifier);

}
