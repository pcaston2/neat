import 'dart:math';

import 'connection.dart';
import 'genome.dart';
import 'node.dart';
import 'activation.dart';

abstract class Mutation {
  late num chance;

  void mutate(Genome g);
}

class LinkMutation implements Mutation {
  @override
  num chance;

  LinkMutation([this.chance = 0.07]);

  @override
  void mutate(Genome g) {
    var links = g.possibleLinks.toList();
    links.shuffle();
    var chosenLink = links.first;
    applyMutation(g, chosenLink);
  }

  void applyMutation(Genome g, Link l) {
    g.addLink(l.from, l.to);
  }
}

class LoopMutation implements Mutation {
  @override
  num chance;
  LoopMutation([this.chance = 0.03]);

  @override
  void mutate(Genome g) {
    var loops = g.possibleLoops.toList();
    loops.shuffle();
    var chosenLoopNode = loops.first;
    applyMutation(g, chosenLoopNode);
  }

  void applyMutation(Genome g, Node n) {
    g.addLoop(n);
  }
}

class NodeMutation extends Mutation {
  @override
  num chance;
  NodeMutation([this.chance = 0.05]);

  @override
  void mutate(Genome g) {
    var possibleNodeLinks = g.possibleNodes.toList();
    possibleNodeLinks.shuffle();
    var chosenNodeLink = possibleNodeLinks.first;
    applyMutation(g, chosenNodeLink);
  }

  void applyMutation(Genome g, Link l) {
    g.addNodeWithLinks(l);
  }
}

class WeightMutation extends Mutation {
  @override
  late num chance;
  late num maximumChange;
  WeightMutation([this.chance = 0.75, this.maximumChange = 0.5]);

  @override
  void mutate(Genome g) {
    var possibleWeightChanges = g.possibleWeightChanges.toList();
    possibleWeightChanges.shuffle();
    var chosenWeightChange = possibleWeightChanges.first;
    applyMutation(g, chosenWeightChange);
  }

  void applyMutation(Genome g, Connection c) {
    var r = Random();
    g.changeWeight(c, (maximumChange / 2) - (r.nextDouble() * maximumChange));
  }
}

class ResetWeightMutation extends Mutation {
  @override
  late num chance;

  ResetWeightMutation([this.chance = 0.10]);

  @override
  void mutate(Genome g) {
    var possibleWeightChanges = g.possibleWeightChanges.toList();
    possibleWeightChanges.shuffle();
    var chosenWeightChange = possibleWeightChanges.first;
    applyMutation(g, chosenWeightChange);
  }

  void applyMutation(Genome g, Connection c) {
    c.weight = Random().nextDouble() * 2 - 1;
  }
}

class ActivationMutation extends Mutation {
  @override
  late num chance;
  ActivationMutation([this.chance = 0.10]);

  @override
  void mutate(Genome g) {
    var possibleActivationChanges = g.possibleActivationChanges.toList();
    possibleActivationChanges.shuffle();
    var chosenActivationChange = possibleActivationChanges.first;
    applyMutation(g, chosenActivationChange);
  }

  void applyMutation(Genome g, Hidden h) {
    h.activationFunction = Activation.random();
  }
}

extension NodeWeighting<T> on List<T> {
  Map<T, num> toWeighted() {
    if (T is Node) {
      var nodes = cast<Node>();
      var weightedMap = <Node, num>{};
      for (var n in nodes) {
        weightedMap[n] = Activation.sigmoid(-n.depth);
      }
      return weightedMap.cast<T, num>();
    } else {
      throw ArgumentError(T.toString() + " is not a subtype of Node");
    }
  }
}


