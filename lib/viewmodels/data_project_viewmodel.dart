import 'package:admin/repositories/data_project_repository.dart';
import 'package:admin/viewmodels/interfaces/search_field_viewmodel_interface.dart';
import 'package:admin/viewmodels/interfaces/table_viewmodel_interface.dart';
import 'package:admin/viewmodels/main_screen_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:provider/provider.dart';

part 'data_project_viewmodel.g.dart';

class DataProjectViewModel with ChangeNotifier 
    implements TableViewModelInterface, SearchFieldViewModelInterface {
  
  final DataProjectRepository dataProjectRepository;

  DataProjectViewModel(
    this.dataProjectRepository
  );

  List<String> _tableColumnList = DataProjectDto.getColumnList();
  List<Map<String, dynamic>> tableDataList = [];

  DataProjectDto? preview;

  void search(String name) async{
    Future<List<DataProjectDto>> data = dataProjectRepository
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

  void delete(String id) async{
    Future<bool> data = dataProjectRepository
        .remoteDataSource
        .deleteDataProjectById(id);

    await data.then((unfuturedStatus) {
      if (unfuturedStatus) {
        print("delete Success!");
      }
    }).whenComplete(() {
      notifyListeners();
    });
  }

  void update(Map<String, dynamic> map) async{
    tableDataList.remove(map);
    
    Future<DataProjectDto> data = dataProjectRepository
        .remoteDataSource
        .updateDataProjectByMap(map);

    await data.then((unfuturedData) {
      tableDataList.add(unfuturedData.toJson());
    }).whenComplete(() {
      notifyListeners();
    });
  }
}

@JsonSerializable()
class DataProjectDto {
  final String? id;
  final String? name;
  final String? author;
  final String? fileText;
  final String? timestamp;
  final Map<String, dynamic>? head;

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
    return ["name", "author", "timestamp", "id"];
  }

}
