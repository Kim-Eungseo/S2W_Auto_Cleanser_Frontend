// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regex_project_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegexProjectDto _$RegexProjectDtoFromJson(Map<String, dynamic> json) =>
    RegexProjectDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
      author: json['author'] as String?,
      regex: json['regex'] as String?,
      timestamp: json['timestamp'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$RegexProjectDtoToJson(RegexProjectDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'author': instance.author,
      'regex': instance.regex,
      'timestamp': instance.timestamp,
      'code': instance.code,
    };
