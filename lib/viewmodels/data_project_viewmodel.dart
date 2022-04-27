import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

class DataProjectViewModel with ChangeNotifier {
  List<DataProjectDto> get dataList => _dataList;
  List<DataProjectDto> _dataList = [];

  DataProjectDto get preview => _preview;
  late DataProjectDto _preview;
  
}

@JsonSerializable()
class DataProjectDto {
  int? id;
  String name;
  String author;
  String fileText;
  String timestamp;
  Map? head;

  DataProjectDto(
    this.id,
    this.name,
    this.author,
    this.fileText,
    this.timestamp,
    this.head
  );

  factory DataProjectDto.fromJson(Map<String, dynamic> json)
  => _$DataProjectDtoFromJson(this)

  Map<String, dynamic> toJson() => _$DataProjectDtoToJson(this);

}
