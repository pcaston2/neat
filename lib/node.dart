import 'gene.dart';
import 'connection.dart';
import 'package:json_annotation/json_annotation.dart';

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

  @override
  late String identifier;

  @override
  int depth = 0;

  Node() : super();

  Node.index(int identifier): super() {
    this.identifier = identifier.toString();
    depth = 0;
  }
}


