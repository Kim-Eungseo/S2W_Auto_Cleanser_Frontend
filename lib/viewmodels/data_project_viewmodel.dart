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
  List<Map<String, dynamic>> tableDataList = [];

  DataProjectDto? preview;
  bool isPreview = false;

  void search(String name) async{
    Future<List<DataProjectDto>> data = dataProjectRepository!
        .remoteDataSource
        .getDataProjectByName(name);

    await data.then((unfuturedDataList) {
      tableDataList = [for (DataProjectDto d in unfuturedDataList) d.toJson()];
    }).whenComplete(() {
      notifyListeners();
    });
  }

  @override
  List<Map<String, dynamic>> getTableDataList() {
   return tableDataList;
  }

  @override
  List<String> get tableColumnList => _tableColumnList;

  @override
  void onRowTap(int index) {

  }
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
