import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:neat/node.dart';

import 'gene.dart';
import 'connection.dart';
part 'genome.g.dart';

@JsonSerializable(explicitToJson: true)
class Genome {
  int inputs;
  int outputs;

  @JsonKey(fromJson: _GeneFromJson, toJson: _GeneToJson)
  List<Gene> genes = <Gene>[];

  static String _GeneToJson(List<Gene> genes) {
    Map<String, dynamic> geneMap = Map<String, dynamic>();
    for(var g in genes) {
      geneMap[g.identifier] = g.toJson();
    }
    return json.encode(geneMap);
  }

  static List<Gene> _GeneFromJson(String json) {
    Map<String, dynamic> genesMap = jsonDecode(json);
    var genes = <Gene>[];
    for (var g in genesMap.values) {
      genes.add(geneFromJson(g, genes));
    }
    return genes;
  }

  static Gene geneFromJson(Map<String, dynamic> json, List<Gene> genes) {
    switch (json['type']) {
      case 'Bias':
        return Bias.fromJson(json);
      case 'Output':
        return Output.fromJson(json);
      case 'Input':
        return Input.fromJson(json);
      case 'Link':
        return Link.fromJsonWithGenes(json, genes);
      case 'Hidden':
        return Hidden.fromJsonWithGenes(json, genes);
      default:
        throw UnimplementedError();
    }
  }

  Genome(this.inputs, this.outputs) {
    int innovationIdentifier = 0;
    List<Node> allInputs = <Node>[];
    allInputs.add(Bias.index(innovationIdentifier++));

    for (int i = 0; i < inputs; i++) {
      var input = Input.index(innovationIdentifier++);
      input.y = 0;
      allInputs.add(input);
    }

    List<Node> allOutputs = <Node>[];
    for (int i = 0; i < outputs; i++) {
      var output = Output.index(innovationIdentifier++);
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

  Iterable<Node> get neurons =>
      genes.whereType<Node>();

  Iterable<Input> get inputNeurons =>
      genes.whereType<Input>();

  Iterable<Output> get outputNeurons =>
      genes.whereType<Output>();

  Bias get biasNeuron =>
      genes.whereType<Bias>().single;

  Iterable<Hidden> get hiddenNeurons =>
      genes.whereType<Hidden>();

  Iterable<Link> get links =>
      genes.whereType<Link>();

  get loops =>
      genes.whereType<Loop>();

  Link addLink(Node from, Node to) {
    if (from == to) {
      throw ArgumentError(
          "Looped Links should be created by calling AddLoopLink");
    }
    if (hasLink(from, to)) {
      throw ArgumentError("This link already exists");
    }
    var newLink = Link(from, to);
    genes.add(newLink);
    return newLink;
  }

  bool hasLink(Node from, Node to) {
    return links.any((l) => l.from == from && l.to == to);
  }

  Iterable<Link> get possibleLinks sync* {
    for(var to in neurons) {
      if (!to.canLinkTo) {
        continue;
      }
      for (var from in neurons) {
        if (from == to) {
          continue;
        }
        if (hasLink(from, to)) {
          continue;
        }
        yield Link(from, to);
      }
    }
  }

  bool get canAddLink {
    return possibleLinks.isNotEmpty;
  }

  Loop addLoopLink(Node loop) {
    if (loop is Bias) {
      throw ArgumentError("Cannot have a loop on a bias neuron");
    }
    if (loop is Input) {
      throw ArgumentError("Cannot have a loop on an input neuron");
    }
    var newLoopLink = Loop.around(loop);
    genes.add(newLoopLink);
    return newLoopLink;
  }

  bool hasLoopLink(Node loop) {
    return loops.any((l) => l.from == loop);
  }

  Iterable<Node> get possibleLoops sync* {
    for(var n in neurons) {
      if (!n.canLoop) {
        continue;
      }
      if (hasLoopLink(n)) {
        continue;
      }
      yield n;
    }
  }

  bool get canAddLoop {
    return possibleLoops.isNotEmpty;
  }

  Hidden addNeuron(Link link) {
    if (link is Loop) {
      throw ArgumentError("Cannot add a neuron to a looped link");
    }
    var newNeuron = Hidden(link);
    genes.add(newNeuron);
    return newNeuron;
  }

  Hidden addNeuronWithLinks(Link link) {
    var neuron = addNeuron(link);
    link.enabled = false;
    addLink(link.from, neuron);
    var toLink = addLink(neuron, link.to);
    toLink.weight = link.weight;
    return neuron;
  }

  bool hasNeuron(Link link) {
    return hiddenNeurons.any((n) => n.link == link);
  }

  Iterable<Link> get possibleNeurons sync* {
    for(var l in links) {
      if (!hasNeuron(l)) {
        yield l;
      }
    }
  }

  bool get canAddNeuron {
    return possibleNeurons.isNotEmpty;
  }

  factory Genome.crossover(Genome fittest, Genome weak) {
    var child = Genome.clone(fittest);
    for (var fitLink in child.links) {
      if (weak.links.any((l) => l.identifier == fitLink.identifier)) {
        var weakLink = weak.links.singleWhere((l) => l.identifier == fitLink.identifier);
        List<Link> choices = [weakLink, fitLink];
        choices.shuffle();
        var choice = choices.first;
        if (choice != fitLink) {
          fitLink.weight = weakLink.weight;
          fitLink.enabled = weakLink.enabled;
        }
      }
    }

    for (var fitLoop in child.loops) {
      if (weak.loops.any((l) => l.identifier == fitLoop.identifier)) {
        var weakLoop = weak.loops.singleWhere((l) => l.identifier == fitLoop.identifier);
        List<Link> choices = [weakLoop, fitLoop];
        choices.shuffle();
        var choice = choices.first;
        if (choice != fitLoop) {
          fitLoop.weight = weakLoop.weight;
          fitLoop.enabled = weakLoop.enabled;
        }
      }
    }

    return child;
  }

  factory Genome.fromJson(Map<String, dynamic> json) => _$GenomeFromJson(json);

  factory Genome.clone(Genome original) {
    return Genome.fromJson(original.toJson());
  }

  Map<String, dynamic> toJson() => _$GenomeToJson(this);
}