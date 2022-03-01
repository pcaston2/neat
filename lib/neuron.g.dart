// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'neuron.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NeuronBias _$NeuronBiasFromJson(Map<String, dynamic> json) => NeuronBias()
  ..x = json['x'] as num
  ..y = json['y'] as num
  ..canLoop = json['canLoop'] as bool
  ..identifier = json['identifier'] as String
  ..depth = json['depth'] as int;

Map<String, dynamic> _$NeuronBiasToJson(NeuronBias instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'canLoop': instance.canLoop,
      'identifier': instance.identifier,
      'depth': instance.depth,
    };
