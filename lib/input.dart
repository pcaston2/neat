part of 'node.dart';

@JsonSerializable(explicitToJson: true)
class Input extends Node {
  Input() : super();
  Input.index(int innovationIdentifier) : super.index(innovationIdentifier);

  @override
  bool get canLoop => false;

  @override
  bool get canLinkTo => false;

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  @override
  void updateInput(Iterable<Connection> inputs) {
    return;
  }

  @override
  Map<String, dynamic> toJson() {
    var result = _$InputToJson(this);
    result['type'] = runtimeType.toString();
    return result;
  }
}