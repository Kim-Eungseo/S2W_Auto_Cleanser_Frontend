import 'package:admin/repositories/data_project_repository.dart';
import 'package:admin/viewmodels/interfaces/search_field_viewmodel_interface.dart';
import 'package:admin/viewmodels/interfaces/table_viewmodel_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_project_viewmodel.g.dart';

class DataProjectViewModel with ChangeNotifier 
    implements TableViewModelInterface, SearchFieldViewModelInterface {
  
  final DataProjectRepository? dataProjectRepository;

  DataProjectViewModel({
    this.dataProjectRepository
  });

  List<String> _tableColumnList = DataProjectDto.getColumnList();
  List<DataProjectDto> tableDataList = [];

  DataProjectDto? preview;
  bool isPreview = false;

  void search(String name) async{
    Future<List<DataProjectDto>> data = dataProjectRepository!
        .remoteDataSource
        .getDataProjectByName(name);

    await data.then((unfuturedDataList) {
      tableDataList = unfuturedDataList;
    }).whenComplete(() {
      for (DataProjectDto d in tableDataList) {
        print(d.toString());
      }
      notifyListeners();
    });
  }

  @override
  List<Map<String, dynamic>> getTableDataList() {
   return [for (DataProjectDto d in tableDataList) d.toJson()];
  }

  @override
  List<String> get tableColumnList => _tableColumnList;
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

  static List<String> getColumnList(){
    return ["id", "name", "author", "timestamp"];
  }
}
