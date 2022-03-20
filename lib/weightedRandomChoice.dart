
import 'dart:math';

extension WeightedChoice<T> on Map<T, num> {
  T weightedChoice() {
    if (values.isEmpty) {
      throw ArgumentError("There are no values in the map");
    }
    if (values.any((e) => e < 0)) {
      throw ArgumentError("Weights must be greater or equal to zero");
    }
    if (!values.any((e) => e > 0)) {
      var options = keys.toList();
      options.shuffle();
      return options.first;
    }
    var max = values.reduce((value, element) => value + element);
    var r = Random();
    var choice = r.nextDouble() * max;
    for (var e in entries) {
      if (e.value == 0) {
        continue;
      }
      if (choice <= e.value) {
        return e.key;
      } else {
        choice -= e.value;
      }
    }
    throw AssertionError("Should never get here");
  }
}