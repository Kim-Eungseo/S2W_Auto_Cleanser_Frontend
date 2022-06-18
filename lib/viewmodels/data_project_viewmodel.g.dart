// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_project_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataProjectDto _$DataProjectDtoFromJson(Map<String, dynamic> json) =>
    DataProjectDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      author: json['author'] as String?,
      fileText: json['fileText'] as String?,
      timestamp: json['timestamp'] as String?,
      head: json['head'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$DataProjectDtoToJson(DataProjectDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'author': instance.author,
      'fileText': instance.fileText,
      'timestamp': instance.timestamp,
      'head': instance.head,
    };
