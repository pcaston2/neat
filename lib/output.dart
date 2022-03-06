part of 'neuron.dart';

@JsonSerializable(explicitToJson: true)
class Output extends Neuron {
  Output() : this.index(0);
  Output.index(int innovationIdentifier) : super.index(innovationIdentifier);

  @override
  bool get canLoop => true;

  @override
  bool get canLinkTo => true;

  factory Output.fromJson(Map<String, dynamic> json) => _$OutputFromJson(json);

  Map<String, dynamic> toJson() {
    var result = _$OutputToJson(this);
    result['type'] = runtimeType.toString();
    return result;
  }
}