// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genome.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Genome _$GenomeFromJson(Map<String, dynamic> json) => Genome(
      json['inputs'] as int,
      json['outputs'] as int,
    )
      ..generation = json['generation'] as int
      ..genes = Genome._GeneFromJson(json['genes'] as String);

Map<String, dynamic> _$GenomeToJson(Genome instance) => <String, dynamic>{
      'inputs': instance.inputs,
      'outputs': instance.outputs,
      'generation': instance.generation,
      'genes': Genome._GeneToJson(instance.genes),
    };
