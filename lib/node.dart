import 'gene.dart';
import 'connection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'activation.dart';

part 'bias.dart';
part 'output.dart';
part 'node.g.dart';
part 'input.dart';
part 'hidden.dart';

abstract class Node implements Gene {
  num x = 0;
  num y = 0;

  bool get canLoop;
  bool get canLinkTo;
  bool get canLinkFrom;

  @JsonKey(ignore: true)
  num input = 0;

  @JsonKey(ignore: true)
  num output = 0;

  @override
  late String identifier;

  @override
  int depth = 0;

  Node() : super();

  Node.index(int identifier): super() {
    this.identifier = identifier.toString();
    depth = 0;
  }

  void updateInput(Iterable<Connection> inputs);

  num getOutput() {
    return output;
  }
}


