// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Species _$SpeciesFromJson(Map<String, dynamic> json) => Species()
  ..genomes = (json['genomes'] as List<dynamic>)
      .map((e) => Genome.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$SpeciesToJson(Species instance) => <String, dynamic>{
      'genomes': instance.genomes.map((e) => e.toJson()).toList(),
    };
