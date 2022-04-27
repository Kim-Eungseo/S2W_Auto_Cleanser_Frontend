import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_project_viewmodel.g.dart';

class DataProjectViewModel with ChangeNotifier {
  List<DataProjectDto> get dataList => _dataList;
  List<DataProjectDto> _dataList = [];

  DataProjectDto get preview => _preview;
  late DataProjectDto _preview;
  
}

@JsonSerializable()
class DataProjectDto {
  final int? id;
  final String? name;
  final String? author;
  final String? fileText;
  final String? timestamp;
  final Map? head;

  DataProjectDto({
    this.id,
    this.name,
    this.author,
    this.fileText,
    this.timestamp,
    this.head
  });

  factory DataProjectDto.fromJson(Map<String, dynamic> json) =>
      _$DataProjectDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DataProjectDtoToJson(this);
}
