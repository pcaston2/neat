part of 'node.dart';

@JsonSerializable(explicitToJson: true)
class Hidden extends Node {

  @JsonKey(fromJson: _LinkFromJson, toJson: _LinkToJson)
  Link link;
  Hidden(this.link) {
    identifier = "{${link.from.identifier},${link.to.identifier}}";
    depth = link.depth;
    x = (link.from.x + link.to.x) / 2;
    y = (link.from.y + link.to.y) / 2;
  }

  @override
  bool get canLoop => true;

  @override
  bool get canLinkTo => true;

  factory Hidden.fromJsonWithGenes(Map<String, dynamic> json, List<Gene> genes) {
    var link = genes.whereType<Link>().singleWhere((g) => g.identifier == json['link']);
    var hidden = Hidden(link);
    hidden.depth = json['depth'];
    hidden.x = json['x'];
    hidden.y = json['y'];
    return hidden;
  }

  factory Hidden.fromJson(Map<String, dynamic> json) => _$HiddenFromJson(json);

  Map<String, dynamic> toJson() {
    var result = _$HiddenToJson(this);
    result['type'] = runtimeType.toString();
    return result;
  }

  static String _LinkToJson(Link link) => link.identifier;
  static Link _LinkFromJson(String json) => throw UnimplementedError();
}