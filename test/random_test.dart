
import 'package:neated/weightedRandomChoice.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('should choose', () {
    //Arrange
    Map<int, num> map = { 1: 0.0001 };
    //Act
    var result = map.weightedChoice();
    //Assert
    expect(result, equals(1));
  });
}
