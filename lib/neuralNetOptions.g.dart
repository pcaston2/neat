// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'neuralNetOptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NeuralNetOptions _$NeuralNetOptionsFromJson(Map<String, dynamic> json) =>
    NeuralNetOptions(
      json['chanceToAddLink'] as num? ?? 0.07,
      json['chanceToAddNode'] as num? ?? 0.03,
      json['chanceToAddLoop'] as num? ?? 0.05,
      json['compatibilityThreshold'] as num? ?? 0.26,
      json['sizeOfGeneration'] as num? ?? 20,
    );

Map<String, dynamic> _$NeuralNetOptionsToJson(NeuralNetOptions instance) =>
    <String, dynamic>{
      'chanceToAddLink': instance.chanceToAddLink,
      'chanceToAddNode': instance.chanceToAddNode,
      'chanceToAddLoop': instance.chanceToAddLoop,
      'compatibilityThreshold': instance.compatibilityThreshold,
      'sizeOfGeneration': instance.sizeOfGeneration,
    };
