// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'neuralNet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NeuralNet _$NeuralNetFromJson(Map<String, dynamic> json) => NeuralNet(
      json['inputs'] as int,
      json['outputs'] as int,
    )
      ..options =
          NeuralNetOptions.fromJson(json['options'] as Map<String, dynamic>)
      ..species = (json['species'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(int.parse(k), Species.fromJson(e as Map<String, dynamic>)),
      );

Map<String, dynamic> _$NeuralNetToJson(NeuralNet instance) => <String, dynamic>{
      'inputs': instance.inputs,
      'outputs': instance.outputs,
      'options': instance.options.toJson(),
      'species':
          instance.species.map((k, e) => MapEntry(k.toString(), e.toJson())),
    };
