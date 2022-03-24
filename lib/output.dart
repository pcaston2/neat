part of 'node.dart';

@JsonSerializable(explicitToJson: true)
class Output extends Node {
  Output() : this.index(0);
  Output.index(int innovationIdentifier) : super.index(innovationIdentifier);

  @override
  bool get canLoop => true;

  @override
  bool get canLinkTo => true;

  @override
  void updateInput(Iterable<Connection> inputs) {
    num sum = 0;
    for(var i in inputs) {
      var node = i.from;
      var weight = i.weight;
      var output = node.getOutput();
      sum += weight * output;
    }
    input = sum;
  }

  factory Output.fromJson(Map<String, dynamic> json) => _$OutputFromJson(json);

  Map<String, dynamic> toJson() {
    var result = _$OutputToJson(this);
    result['type'] = runtimeType.toString();
    return result;
  }
}