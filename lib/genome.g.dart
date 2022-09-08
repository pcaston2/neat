// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genome.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Genome _$GenomeFromJson(Map<String, dynamic> json) => Genome(
      json['inputCount'] as int,
      json['outputCount'] as int,
    )
      ..fitness = json['fitness'] as num
      ..genes = Genome._GeneFromJson(json['genes']);

Map<String, dynamic> _$GenomeToJson(Genome instance) => <String, dynamic>{
      'inputCount': instance.inputCount,
      'outputCount': instance.outputCount,
      'fitness': instance.fitness,
      'genes': Genome._GeneToJson(instance.genes),
    };
