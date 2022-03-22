part of 'connection.dart';

@JsonSerializable(explicitToJson: true)
class Link extends Connection {
  Link(Node from, Node to) : super(from, to);

  factory Link.fromJsonWithGenes(Map<String, dynamic> json, List<Gene> genes) {
    var from = genes.whereType<Node>().singleWhere((g) => g.identifier == json['from']);
    var to = genes.whereType<Node>().singleWhere((g) => g.identifier == json['to']);
    var link = Link(from, to);
    link.weight = json['weight'];
    link.enabled = json['enabled'];
    return link;
  }

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var result = _$LinkToJson(this);
    result['type'] = runtimeType.toString();
    return result;
  }
}