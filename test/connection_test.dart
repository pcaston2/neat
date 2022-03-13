import 'package:test/test.dart';
import 'package:neat/genome.dart';

void main() {
  group('Connection', ()
  {
    test('should find', () {
      //Arrange
      Genome g = Genome(1, 1);
      var input = g.inputs.single;
      var output = g.outputs.single;
      g.addLink(input, output);
      g.addLoop(output);
      //Act
      var connections = g.connections;
      //Assert
      expect(connections.length, equals(2));
    });
  });
}