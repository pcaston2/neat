
import 'dart:math';

extension WeightedChoice<T> on Map<T, num> {
  T weightedChoice() {
    if (values.any((e) => e <= 0)) {
      throw ArgumentError("Weights must be greater than zero");
    }
    var max = values.reduce((value, element) => value + element);
    var r = Random();
    var choice = r.nextDouble() * max;
    for (var e in entries) {
      if (choice <= e.value) {
        return e.key;
      } else {
        choice -= e.value;
      }
    }
    throw AssertionError("Should never get here");
  }
}