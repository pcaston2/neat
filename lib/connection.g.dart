// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      Connection._NeuronFromJson(json['from'] as String),
      Connection._NeuronFromJson(json['to'] as String),
    )
      ..identifier = json['identifier'] as String
      ..depth = json['depth'] as int
      ..weight = json['weight'] as num
      ..enabled = json['enabled'] as bool;

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'identifier': instance.identifier,
      'depth': instance.depth,
      'from': Connection._NeuronToJson(instance.from),
      'to': Connection._NeuronToJson(instance.to),
      'weight': instance.weight,
      'enabled': instance.enabled,
    };
