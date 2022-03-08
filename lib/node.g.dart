// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bias _$BiasFromJson(Map<String, dynamic> json) => Bias()
  ..x = json['x'] as num
  ..y = json['y'] as num
  ..identifier = json['identifier'] as String
  ..depth = json['depth'] as int;

Map<String, dynamic> _$BiasToJson(Bias instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'identifier': instance.identifier,
      'depth': instance.depth,
    };

Output _$OutputFromJson(Map<String, dynamic> json) => Output()
  ..x = json['x'] as num
  ..y = json['y'] as num
  ..identifier = json['identifier'] as String
  ..depth = json['depth'] as int;

Map<String, dynamic> _$OutputToJson(Output instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'identifier': instance.identifier,
      'depth': instance.depth,
    };

Input _$InputFromJson(Map<String, dynamic> json) => Input()
  ..x = json['x'] as num
  ..y = json['y'] as num
  ..identifier = json['identifier'] as String
  ..depth = json['depth'] as int;

Map<String, dynamic> _$InputToJson(Input instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'identifier': instance.identifier,
      'depth': instance.depth,
    };

Hidden _$HiddenFromJson(Map<String, dynamic> json) => Hidden(
      Hidden._LinkFromJson(json['link'] as String),
    )
      ..x = json['x'] as num
      ..y = json['y'] as num
      ..identifier = json['identifier'] as String
      ..depth = json['depth'] as int;

Map<String, dynamic> _$HiddenToJson(Hidden instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'identifier': instance.identifier,
      'depth': instance.depth,
      'link': Hidden._LinkToJson(instance.link),
    };
