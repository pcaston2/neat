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
    allInputs.add(BiasNeuron(innovationIdentifier++));
    for (int i = 0; i < inputs; i++) {
      var input = InputNeuron(innovationIdentifier++);
      input.y = 0;
      allInputs.add(input);
    }

    List<Neuron> allOutputs = <Neuron>[];
    for (int i = 0; i < outputs; i++) {
      var output = OutputNeuron(innovationIdentifier++);
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

  get neurons =>
      genes.whereType<Neuron>();

  get inputNeurons =>
      genes.whereType<InputNeuron>();

  get outputNeurons =>
      genes.whereType<OutputNeuron>();

  get biasNeurons =>
      genes.whereType<BiasNeuron>();

  get hiddenNeurons =>
      genes.whereType<HiddenNeuron>();

  get links =>
      genes.whereType<Link>();

  get loops =>
      genes.whereType<LoopLink>();

  Link addLink(Neuron from, Neuron to) {
    if (from == to) {
      throw ArgumentError(
          "Looped Links should be created by calling AddLoopLink");
    }
    if (hasLink(from, to)) {
      throw ArgumentError("This link already exists");
    }
    var newLink = Link(from, to);
    newLink.geneIdentifier = "(${from.geneIdentifier},${to.geneIdentifier})";
    genes.add(newLink);
    return newLink;
  }

  bool hasLink(Neuron from, Neuron to) {
    return links.any((l) => l.from == from && l.to == to);
  }

  LoopLink addLoopLink(Neuron loop) {
    if (loop is BiasNeuron) {
      throw ArgumentError("Cannot have a loop on a bias neuron");
    }
    if (loop is InputNeuron) {
      throw ArgumentError("Cannot have a loop on an input neuron");
    }
    var newLoopLink = LoopLink(loop);
    newLoopLink.geneIdentifier =
    "(${loop.geneIdentifier},${loop.geneIdentifier})";
    genes.add(newLoopLink);
    return newLoopLink;
  }

  bool hasLoopLink(Neuron loop) {
    return loops.any((l) => l.from == loop);
  }

  HiddenNeuron addNeuron(Link link) {
    if (link is LoopLink) {
      throw ArgumentError("Cannot add a neuron to a looped link");
    }
    var newNeuron = HiddenNeuron(link);
    genes.add(newNeuron);
    return newNeuron;
  }

  bool hasNeuron(Link link) {
    return hiddenNeurons.any((n) => n.link == link);
  }
}