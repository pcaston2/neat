part of 'connection.dart';

class Loop extends Connection {
  Loop(Neuron loop) : super(loop, loop);
  Map<String, dynamic> toJson() => throw UnimplementedError();
}