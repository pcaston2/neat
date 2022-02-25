import 'package:neat/neuron.dart';
import 'package:neat/neuronInnovation.dart';

import 'innovation.dart';
import 'linkInnovation.dart';

class Phenotype {
  int inputs;
  int outputs;

  List<Innovation> innovations = <Innovation>[];

  Phenotype(this.inputs, this.outputs) {
    int innovationIdentifier = 0;
    List<NeuronInnovation> allInputs = <NeuronInnovation>[];
    allInputs.add(new BiasNeuronInnovation(innovationIdentifier++));
    for (int i=0; i<inputs; i++) {
      var input = new InputNeuronInnovation(innovationIdentifier++);
      input.y = 0;
      allInputs.add(input);
    }

    List<NeuronInnovation> allOutputs = <NeuronInnovation>[];
    for (int i=0; i<outputs; i++) {
      var output = new OutputNeuronInnovation(innovationIdentifier++);
      output.y = 1;
      allOutputs.add(output);
    }

    if (allInputs.length == 1) {
      allInputs.first.x = 0.5;
    } else {
      for (int i = 0; i < allInputs.length; i++) {
        var current = allInputs[i];
        current.x = i / (allInputs.length - 1);
      }
    }

    if (allOutputs.length == 1) {
      allOutputs.first.x = 0.5;
    } else {
      for (int i = 0; i < allOutputs.length; i++) {
        var current = allOutputs[i];
        current.y = i / (allInputs.length - 1);
      }
    }

    innovations.addAll(allInputs);
    innovations.addAll(allOutputs);
  }

  neurons() =>
    this.innovations.whereType<NeuronInnovation>();

  inputNeurons() =>
    this.innovations.whereType<InputNeuronInnovation>();

  Iterable<OutputNeuronInnovation> outputNeurons() =>
    this.innovations.whereType<OutputNeuronInnovation>();

  Iterable<BiasNeuronInnovation> biasNeurons() =>
    this.innovations.whereType<BiasNeuronInnovation>();

  Iterable<HiddenNeuronInnovation> hiddenNeurons() =>
    this.innovations.whereType<HiddenNeuronInnovation>();

  Iterable<LinkInnovation> links() =>
    this.innovations.whereType<LinkInnovation>();

}