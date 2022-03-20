import 'package:neat/genome.dart';
import 'package:test/test.dart';
import 'package:neat/species.dart';

void main() {
  group('Species', () {
    test('should find fittest', () {
      //Arrange
      var lo = Genome(0,1);
      lo.fitness = 0;
      var mid = Genome(0,1);
      mid.fitness = 1;
      var hi = Genome(0,1);
      hi.fitness = 2;
      var species = Species(mid);
      //Act
      species.add(lo);
      species.add(mid);
      species.add(hi);
      //Assert
      expect(species.representative, equals(mid));
      expect(species.fittest, equals(hi));
    });
  });
}