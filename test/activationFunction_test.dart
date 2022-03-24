import 'package:test/test.dart';
import 'package:neat/activation.dart';

void main() {
  group('Activation Function', ()
  {
    test('should get low signal', () {
      //Arrange
      var input = -1;
      //Act
      var output = Activation.sigmoid(input);
      //Assert
      expect(output, lessThan(0.5));
    });

    test('should get high signal', () {
      //Arrange
      var input = 1;
      //Act
      var output = Activation.sigmoid(input);
      //Assert
      expect(output, greaterThan(0.5));
    });

    test('should middle signal', () {
      //Arrange
      var input = 0;
      //Act
      var output = Activation.sigmoid(input);
      //Assert
      expect(output, equals(0.5));
    });
  });
}