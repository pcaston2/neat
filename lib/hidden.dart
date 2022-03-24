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
    activationFunction = Activation.random();
  }

  @override
  bool get canLoop => true;

  @override
  bool get canLinkTo => true;

  @JsonKey(ignore: true)
  late Activation activationFunction;

  factory Hidden.fromJsonWithGenes(Map<String, dynamic> json, List<Gene> genes) {
    var link = genes.whereType<Link>().singleWhere((g) => g.identifier == json['link']);
    var hidden = Hidden(link);
    hidden.activationFunction = Activation.fromType(json['activation']);
    hidden.depth = json['depth'];
    hidden.x = json['x'];
    hidden.y = json['y'];
    return hidden;
  }

  //factory Hidden.fromJson(Map<String, dynamic> json) => _$HiddenFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var result = _$HiddenToJson(this);
    result['activation'] = activationFunction.runtimeType.toString();
    result['type'] = runtimeType.toString();
    return result;
  }

  @override
  void updateInput(Iterable<Connection> inputs) {
    num sum = 0;
    for(var i in inputs) {
      var node = i.from;
      var weight = i.weight;
      var output = node.getOutput();
      sum += weight * output;
    }
    input = activationFunction.f(sum);
  }

  static String _LinkToJson(Link link) => link.identifier;
  static Link _LinkFromJson(String json) => throw UnimplementedError();
}