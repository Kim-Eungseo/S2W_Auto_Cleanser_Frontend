import 'package:admin/repositories/data_project_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_project_viewmodel.g.dart';

class DataProjectViewModel with ChangeNotifier {
  late final DataProjectRepository _dataProjectRepository;

  List<DataProjectDto> dataList = [];
  late DataProjectDto preview;
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

  @override
  String toString() {
    return 'DataProjectDto{id: $id, name: $name, author: $author, fileText: $fileText, timestamp: $timestamp, head: $head}';
  }
}
