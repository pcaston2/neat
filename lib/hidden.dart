part of 'neuron.dart';

@JsonSerializable(explicitToJson: true)
class Hidden extends Neuron {

  @JsonKey(fromJson: _LinkFromJson, toJson: _LinkToJson)
  Link link;
  Hidden(this.link) {
    identifier = "{${link.from.identifier},${link.to.identifier}}";
    depth = link.depth + 1;
    x = (link.from.x + link.to.x) / 2;
    y = (link.from.y + link.to.y) / 2;
  }

  @override
  bool get canLoop => true;

  factory Hidden.fromJson(Map<String, dynamic> json) => _$HiddenFromJson(json);

  Map<String, dynamic> toJson() {
    var result = _$HiddenToJson(this);
    result['type'] = runtimeType.toString();
    return result;
  }

  static String _LinkToJson(Link link) => link.identifier;
  static Link _LinkFromJson(String json) => throw UnimplementedError();
}