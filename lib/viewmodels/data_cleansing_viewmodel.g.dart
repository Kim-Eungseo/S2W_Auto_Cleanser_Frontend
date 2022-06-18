// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_cleansing_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CleansingProcessDto _$CleansingProcessDtoFromJson(Map<String, dynamic> json) =>
    CleansingProcessDto(
      col_name: json['col_name'] as String?,
      regex_id: json['regex_id'] as String?,
    );

Map<String, dynamic> _$CleansingProcessDtoToJson(
        CleansingProcessDto instance) =>
    <String, dynamic>{
      'col_name': instance.col_name,
      'regex_id': instance.regex_id,
    };
