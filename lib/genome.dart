import 'package:neat/neuron.dart';

import 'gene.dart';
import 'link.dart';

class Genome {
  int inputs;
  int outputs;

  List<Gene> genes = <Gene>[];

  Genome(this.inputs, this.outputs) {
    int innovationIdentifier = 0;
    List<Neuron> allInputs = <Neuron>[];
    allInputs.add(new BiasNeuron(innovationIdentifier++));
    for (int i=0; i<inputs; i++) {
      var input = new InputNeuron(innovationIdentifier++);
      input.y = 0;
      allInputs.add(input);
    }

    List<Neuron> allOutputs = <Neuron>[];
    for (int i=0; i<outputs; i++) {
      var output = new OutputNeuron(innovationIdentifier++);
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

    genes.addAll(allInputs);
    genes.addAll(allOutputs);
  }

  neurons() =>
      genes.whereType<Neuron>();

  inputNeurons() =>
      genes.whereType<InputNeuron>();

  outputNeurons() =>
      genes.whereType<OutputNeuron>();

  biasNeurons() =>
      genes.whereType<BiasNeuron>();

  hiddenNeurons() =>
      genes.whereType<HiddenNeuron>();

  links() =>
      genes.whereType<Link>();

  loops() =>
      genes.whereType<LoopLink>();

  Link AddLink(Neuron from, Neuron to) {
    var newLink = Link(from, to);
    newLink.geneIdentifier = "(${from.geneIdentifier},${to.geneIdentifier})";
    genes.add(newLink);
    return newLink;
  }
}