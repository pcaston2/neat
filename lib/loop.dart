part of 'connection.dart';

@JsonSerializable(explicitToJson: true)
class Loop extends Connection {
  Loop.around(Node loop) : super(loop, loop) {
    identifier = '(' + loop.identifier + ')';
  }
  Loop(Node from, Node to) : this.around(from);

  factory Loop.fromJsonWithGenes(Map<String, dynamic> json, List<Gene> genes) {
    var loopGene = genes.whereType<Node>().singleWhere((g) => g.identifier == json['from']);
    var link = Loop.around(loopGene);
    link.weight = json['weight'];
    link.enabled = json['enabled'];
    return link;
  }

  factory Loop.fromJson(Map<String, dynamic> json) => _$LoopFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var result = _$LoopToJson(this);
    result['type'] = runtimeType.toString();
    return result;
  }
}