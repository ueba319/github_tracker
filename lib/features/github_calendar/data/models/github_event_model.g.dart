// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GitHubEventModelImpl _$$GitHubEventModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GitHubEventModelImpl(
      type: json['type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$GitHubEventModelImplToJson(
        _$GitHubEventModelImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'created_at': instance.createdAt.toIso8601String(),
    };
