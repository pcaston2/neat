part of 'node.dart';

@JsonSerializable(explicitToJson: true)
class Bias extends Node {

  Bias() : this.index(0);

  Bias.index(int innovationIdentifier) : super.index(innovationIdentifier);

  @override
  bool get canLoop => false;

  @override
  bool get canLinkTo => false;

  @override
  num getOutput() {
    return 1;
  }

  @override
  void updateInput(Iterable<Connection> inputs) {
    return;
  }

  factory Bias.fromJson(Map<String, dynamic> json) => _$BiasFromJson(json);

  Map<String, dynamic> toJson() {
    var result = _$BiasToJson(this);
    result['type'] = runtimeType.toString();
    return result;
  }
}