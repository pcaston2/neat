import 'gene.dart';
import 'connection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bias.dart';
part 'output.dart';
part 'neuron.g.dart';
part 'input.dart';
part 'hidden.dart';

abstract class Neuron implements Gene {
  num x = 0;
  num y = 0;

  @JsonKey(ignore: true)
  bool get canLoop;

  @override
  late String identifier;

  @override
  int depth = 0;

  Neuron() : super();

  Neuron.index(int identifier): super() {
    this.identifier = identifier.toString();
    depth = 0;
  }

  // Map<String, dynamic> toJson() {
  //   var result = Map<String, dynamic>();
  //   result['fake'] = true;
  //   return result;
  // }
  //
  // factory Neuron.fromJson(Map<String, dynamic> json) {
  //   switch (json['type']) {
  //     case 'Input':
  //       return Input.fromJson(json);
  //     case 'Output':
  //       return Output.fromJson(json);
  //     case 'Hidden':
  //       return Hidden.fromJson(json);
  //     case 'Bias':
  //       return Bias.fromJson(json);
  //     default:
  //       throw UnimplementedError("The type '" + json['type'] + "' is not mapped.");
  //   }
  // }
}


