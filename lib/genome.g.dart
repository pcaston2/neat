// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genome.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Genome _$GenomeFromJson(Map<String, dynamic> json) => Genome(
      json['inputCount'] as int,
      json['outputCount'] as int,
    )
      ..generation = json['generation'] as int
      ..genes = Genome._GeneFromJson(json['genes'] as String);

Map<String, dynamic> _$GenomeToJson(Genome instance) => <String, dynamic>{
      'inputCount': instance.inputCount,
      'outputCount': instance.outputCount,
      'generation': instance.generation,
      'genes': Genome._GeneToJson(instance.genes),
    };
