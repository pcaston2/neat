// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Generation _$GenerationFromJson(Map<String, dynamic> json) => Generation()
  ..genomes = (json['genomes'] as List<dynamic>)
      .map((e) => Genome.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$GenerationToJson(Generation instance) =>
    <String, dynamic>{
      'genomes': instance.genomes.map((e) => e.toJson()).toList(),
    };
