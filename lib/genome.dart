import 'dart:convert';
import 'dart:math';

import 'package:json_annotation/json_annotation.dart';
import 'node.dart';
import 'weightedRandomChoice.dart';
import 'gene.dart';
import 'connection.dart';
import 'mutation.dart';
part 'genome.g.dart';

@JsonSerializable(explicitToJson: true)
class Genome {
  int inputCount;
  int outputCount;
  num fitness = 0;

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
        current.y = 1;
        current.x = i / (allOutputs.length - 1);
      }
    }
    genes.addAll(allInputs);
    genes.addAll(allOutputs);
  }

  Map<Mutation, num> getPossibleMutations() {
    var mutations = <Mutation, num>{};
    if (canAddNode) {
      var mutation = NodeMutation();
      mutations[mutation] = mutation.chance;
    }
    if (canAddLink) {
      var mutation = LinkMutation();
      mutations[mutation] = mutation.chance;
    }
    if (canAddLoop) {
      var mutation = LoopMutation();
      mutations[mutation] = mutation.chance;
    }
    if (canChangeWeight) {
      var mutation = WeightMutation();
      mutations[mutation] = mutation.chance;
    }
    if (canChangeActivation) {
      var mutation = ActivationMutation();
      mutations[mutation] = mutation.chance;
    }
    if (canResetActivation) {
      var mutation = ResetWeightMutation();
      mutations[mutation] = mutation.chance;
    }
    if (mutations.isEmpty) {
      throw UnsupportedError("There are no possible mutations for this genome");
    }
    return mutations;
  }

  factory Genome.mutate(Genome g) {
    var result = Genome.clone(g);
    var mutations = result.getPossibleMutations();
    var mutation = mutations.weightedChoice();
    mutation.mutate(result);
    return result;
  }

  Genome mutate() {
    return Genome.mutate(this);
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

  void update() {
    updateInputs();
    transferToOutputs();
  }

  void clear() {
    for (var n in nodes) {
      n.input = 0;
      n.output = 0;
    }
  }


  void updateInputs() {
    for(var n in nodes) {
      var inputs = getInputConnections(n);
      n.updateInput(inputs);
    }
  }

  Iterable<Connection> getInputConnections(Node n) {
    return connections.where((c) => c.enabled && c.to == n);
  }

  void transferToOutputs() {
    for (var n in nodes) {
      n.output = n.input;
    }
  }

  void registerInputs(List<num> inputs) {
    if (inputs.length != inputCount) {
      throw ArgumentError("Incorrect number of inputs passed, expecting $inputCount but received  ${inputs.length}", "inputs");
    }
    var genomeInputs = this.inputs.toList();
    for (int i = 0;i<inputs.length;i++) {
      genomeInputs[i].output = inputs[i];
    }
  }

  List<num> getOutputs() {
    var outputValues = <num>[];
    for (var o in outputs) {
      outputValues.add(o.output);
    }
    return outputValues;
  }

  bool isSameSpecies(Genome g, [num tolerance = 0.26]) {
    return geneticDifference(g) < tolerance;
  }

  num geneticDifference(Genome g2) {
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


  Iterable<Connection> get possibleWeightChanges sync* {
    for(var c in connections) {
      if (c.enabled) {
        yield c;
      }
    }
  }

  bool get canChangeWeight => possibleWeightChanges.isNotEmpty;

  Iterable<Hidden> get possibleActivationChanges sync* {
    for (var h in hiddens) {
      yield h;
    }
  }

  bool get canChangeActivation => possibleActivationChanges.isNotEmpty;

  void changeWeight(Connection c, num change) {
    c.weight += change;
  }


  bool get canResetActivation => possibleWeightChanges.isNotEmpty;


  Link addLink(Node from, Node to) {
    if (from == to) {
      throw ArgumentError("Looped Links should be created by calling addLoop");
    }
    if (hasLink(from, to)) {
      throw ArgumentError("This link already exists");
    }
    var newLink = Link(from, to);
    newLink.weight = Random().nextDouble() * 2 -1;
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
    newLoop.weight = Random().nextDouble() * 2 -1;
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

  Hidden addNode(Link link) {
    if (link is Loop) {
      throw ArgumentError("Cannot add a neuron to a looped link");
    }
    var newNeuron = Hidden(link);
    genes.add(newNeuron);
    return newNeuron;
  }

  Hidden addNodeWithLinks(Link link) {
    var neuron = addNode(link);
    link.enabled = false;
    var fromLink = addLink(link.from, neuron);
    fromLink.weight = 1;
    var toLink = addLink(neuron, link.to);
    toLink.weight = link.weight;
    return neuron;
  }

  bool hasNode(Link link) {
    return hiddens.any((n) => n.link == link);
  }

  Iterable<Link> get possibleNodes sync* {
    for(var l in links) {
      if (!hasNode(l) && l.enabled) {
        yield l;
      }
    }
  }

  bool get canAddNode {
    return possibleNodes.isNotEmpty;
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
      case 'Loop':
        return Loop.fromJsonWithGenes(json, genes);
      case 'Hidden':
        return Hidden.fromJsonWithGenes(json, genes);
      default:
        throw UnimplementedError("Type " + json['type'] + " cannot be deserialized");
    }
  }

  static String _GeneToJson(List<Gene> genes) {
    Map<String, dynamic> geneMap = Map<String, dynamic>();
    for (var g in genes) {
      geneMap[g.identifier] = g.toJson();
    }
    return jsonEncode(geneMap);
  }


}