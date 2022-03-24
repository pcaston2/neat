import 'package:json_annotation/json_annotation.dart';
import 'dart:math' as math;
part 'activation.g.dart';

abstract class Activation {
  Activation();
  num f(num value);

  Map<String, dynamic> toJson();

  factory Activation.fromType(String type) {
    switch (type) {
      case 'Sigmoid':
        return Sigmoid();
      case 'ReLU':
        return ReLU();
      case 'Tanh':
        return Tanh();
      case 'Gaussian':
        return Gaussian();
    }
    return Sigmoid();
  }

  factory Activation.standardFunction() {
    return Tanh();
  }

  factory Activation.random() {
    var activations = <Activation>[];
    activations.addAll([
      Sigmoid(),
      ReLU(),
      Tanh(),
      Gaussian()]
    );
    activations.shuffle();
    return activations.first;
  }

  static num sigmoid(num value) {
    return 1/(1+math.exp(-value));
  }

  static num reLU(num value) {
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

  static num gaussian(num value) {
    return math.exp(-math.pow(value, 2));
  }

  static num standard(num value) {
    return Activation.reLU(value);
  }
}

@JsonSerializable(explicitToJson: true)
class Sigmoid implements Activation {
  Sigmoid();

  @override
  num f(num value) {
    return Activation.sigmoid(value);
  }

  factory Sigmoid.fromJson(Map<String, dynamic> json) => _$SigmoidFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var result = _$SigmoidToJson(this);
    result['type'] = runtimeType.toString();
    return result;
  }
}

@JsonSerializable(explicitToJson: true)
class ReLU implements Activation {
  ReLU();

  @override
  num f(num value) {
    return Activation.reLU(value);
  }

  factory ReLU.fromJson(Map<String, dynamic> json) => _$ReLUFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var result = _$ReLUToJson(this);
    result['type'] = runtimeType.toString();
    return result;
  }
}

@JsonSerializable(explicitToJson: true)
class Tanh implements Activation {
  Tanh();

  @override
  num f(num value) {
    return Activation.tanh(value);
  }

  factory Tanh.fromJson(Map<String, dynamic> json) => _$TanhFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var result = _$TanhToJson(this);
    result['type'] = runtimeType.toString();
    return result;
  }
}

@JsonSerializable(explicitToJson: true)
class Gaussian implements Activation {
  Gaussian();

  @override
  num f(num value) {
    return Activation.gaussian(value);
  }
  factory Gaussian.fromJson(Map<String, dynamic> json) => _$GaussianFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var result = _$GaussianToJson(this);
    result['type'] = runtimeType.toString();
    return result;
  }
}