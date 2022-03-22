import 'dart:math' as math;

class ActivationFunction {

  static num sigmoid(num value) {
    return 1/(1+math.exp(-value));
  }

  static num ReLU(num value) {
    if (value < 0) {
      return value * 0.01;
    } else {
      return value;
    }
  }

  static num tanh(num value) {
    if (value > 19.1) {
      return 1.0;
    }

    if (value < -19.1) {
      return -1.0;
    }

    var e1 = math.exp(value);
    var e2 = math.exp(-value);
    return (e1 - e2) / (e1 + e2);
  }

  static num activationFunction(num value) {
    return ReLU(value);
  }
}