import 'package:admin/repositories/data_project_repository.dart';
import 'package:admin/viewmodels/interfaces/search_field_viewmodel_interface.dart';
import 'package:admin/viewmodels/interfaces/table_viewmodel_interface.dart';
import 'package:admin/viewmodels/main_screen_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:provider/provider.dart';

import '../repositories/regex_project_repository.dart';

part 'regex_project_viewmodel.g.dart';

class RegexProjectViewModel with ChangeNotifier
    implements TableViewModelInterface, SearchFieldViewModelInterface {

  final RegexProjectRepository regexProjectRepository;

  RegexProjectViewModel(
      this.regexProjectRepository
      );

  List<String> _tableColumnList = RegexProjectDto.getColumnList();
  List<Map<String, dynamic>> tableDataList = [];

  RegexProjectDto? preview;

  void search(String name) async{
    Future<List<RegexProjectDto>> data = regexProjectRepository
        .remoteDataSource
        .getRegexProjectByName(name);

    await data.then((unfuturedDataList) {
      tableDataList = [for (RegexProjectDto d in unfuturedDataList) d.toJson()];
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


}

@JsonSerializable()
class RegexProjectDto {
  final int? id;
  final String? name;
  final String? author;
  final String? regex;
  final String? timestamp;
  final String? code;

  RegexProjectDto({
    this.id,
    this.name,
    this.author,
    this.regex,
    this.timestamp,
    this.code,
  });

  factory RegexProjectDto.fromJson(Map<String, dynamic> json) =>
      _$RegexProjectDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegexProjectDtoToJson(this);

  @override
  String toString() {
    return 'RegexProjectDto{id: $id, name: $name, author: $author, regex: $regex, timestamp: $timestamp, code: $code}';
  }

  static List<String> getColumnList(){
    return ["id", "name", "author", "timestamp", "regex"];
  }

}
