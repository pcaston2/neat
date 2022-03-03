part of 'connection.dart';

//@JsonSerializable(explicitToJson: true)
//@CustomNeuronConverter()
class Link extends Connection {
  Link.between(Neuron from,Neuron to) : super (from, to);

  //factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  Map<String, dynamic> toJson() => throw UnimplementedError();//_$LinkToJson(this);
}