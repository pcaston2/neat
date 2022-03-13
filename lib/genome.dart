import 'dart:convert';
import 'dart:math';

import 'package:json_annotation/json_annotation.dart';
import 'package:neat/node.dart';

import 'gene.dart';
import 'connection.dart';
part 'genome.g.dart';

@JsonSerializable(explicitToJson: true)
class Genome {
  int inputCount;
  int outputCount;
  int generation = 0;

  @JsonKey(fromJson: _GeneFromJson, toJson: _GeneToJson)
  List<Gene> genes = <Gene>[];

  Genome(this.inputCount, this.outputCount) {
    int innovationIdentifier = 0;
    List<Node> allInputs = <Node>[];
    allInputs.add(Bias.index(innovationIdentifier++));

    for (int i = 0; i < inputCount; i++) {
      var input = Input.index(innovationIdentifier++);
      input.y = 0;
      allInputs.add(input);
    }

    List<Node> allOutputs = <Node>[];
    for (int i = 0; i < outputCount; i++) {
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

  factory Genome.crossover(Genome fittest, Genome weak) {
    var child = Genome.clone(fittest);
    for (var fitLink in child.connections) {
      if (weak.connections.any((l) => l.identifier == fitLink.identifier)) {
        var weakLink = weak.connections.singleWhere((l) => l.identifier == fitLink.identifier);
        List<Connection> choices = [weakLink, fitLink];
        choices.shuffle();
        var choice = choices.first;
        if (choice != fitLink) {
          fitLink.weight = weakLink.weight;
          fitLink.enabled = weakLink.enabled;
        }
      }
    }

    return child;
  }

  bool isSameSpecies(Genome g, [num tolerance = 0.26]) {
    return speciesDifference(g) < tolerance;
  }

  num speciesDifference(Genome g2) {
    var g1 = this;
    int maxConnections = max(g1.connections.length, g2.connections.length);
    if (maxConnections == 0) {
      return 0;
    }
    int connectionDifference = 0;
    num weightDifference = 0;
    for(var conn1 in g1.connections) {
      if (g2.connections.any((c) => c.identifier == conn1.identifier)) {
        var conn2 = g2.connections.singleWhere((c) => c.identifier == conn1.identifier);
        if (conn1.enabled && conn2.enabled) {
          weightDifference += (conn1.weight - conn2.weight).abs();
        } else {
          connectionDifference++;
        }
      } else {
        connectionDifference++;
      }
    }
    for(var conn2 in g2.connections) {
      if (!g1.connections.any((c) => c.identifier == conn2.identifier)) {
        connectionDifference++;
      }
    }
    return connectionDifference / maxConnections + weightDifference;
  }

  Iterable<Node> get nodes =>
      genes.whereType<Node>();

  Iterable<Input> get inputs =>
      genes.whereType<Input>();

  Iterable<Output> get outputs =>
      genes.whereType<Output>();

  Bias get bias =>
      genes.whereType<Bias>().single;

  Iterable<Hidden> get hiddens =>
      genes.whereType<Hidden>();

  Iterable<Connection> get connections =>
      genes.whereType<Connection>();

  Iterable<Link> get links =>
      genes.whereType<Link>();

  get loops =>
      genes.whereType<Loop>();

  Link addLink(Node from, Node to) {
    if (from == to) {
      throw ArgumentError(
          "Looped Links should be created by calling addLoop");
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
    for(var to in nodes) {
      if (!to.canLinkTo) {
        continue;
      }
      for (var from in nodes) {
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

  Loop addLoop(Node loop) {
    if (loop is Bias) {
      throw ArgumentError("Cannot have a loop on a bias neuron");
    }
    if (loop is Input) {
      throw ArgumentError("Cannot have a loop on an input neuron");
    }
    var newLoop = Loop.around(loop);
    genes.add(newLoop);
    return newLoop;
  }

  bool hasLoop(Node loop) {
    return loops.any((l) => l.from == loop);
  }

  Iterable<Node> get possibleLoops sync* {
    for(var n in nodes) {
      if (!n.canLoop) {
        continue;
      }
      if (hasLoop(n)) {
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
    return hiddens.any((n) => n.link == link);
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

  factory Genome.fromJson(Map<String, dynamic> json) => _$GenomeFromJson(json);

  factory Genome.clone(Genome original) {
    return Genome.fromJson(original.toJson());
  }

  Map<String, dynamic> toJson() => _$GenomeToJson(this);


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


  static String _GeneToJson(List<Gene> genes) {
    Map<String, dynamic> geneMap = Map<String, dynamic>();
    for(var g in genes) {
      geneMap[g.identifier] = g.toJson();
    }
    return jsonEncode(geneMap);
  }
}