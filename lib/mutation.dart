

abstract class Mutation {
  late num weight;
  Mutation(this.weight);
}

class LinkMutation extends Mutation {
  LinkMutation([num weight = 0.07]) : super(weight);
}

class LinkedLoopMutation extends Mutation {
  LinkedLoopMutation([num weight = 0.03]) : super(weight);
}
