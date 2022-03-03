part of '../neuron.dart';

@JsonSerializable(explicitToJson: true)
class Input extends Neuron {
  Input() : super();
  Input.index(int innovationIdentifier) : super.index(innovationIdentifier);

  @override
  bool get canLoop => false;

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  Map<String, dynamic> toJson() {
    var result = _$InputToJson(this);
    result['type'] = runtimeType.toString();
    return result;
  }
}