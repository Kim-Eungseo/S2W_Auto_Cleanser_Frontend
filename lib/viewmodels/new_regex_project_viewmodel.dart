import 'package:admin/repositories/data_project_repository.dart';
import 'package:admin/repositories/regex_project_repository.dart';
import 'package:admin/viewmodels/interfaces/codable_viewmodel_interface.dart';
import 'package:flutter/material.dart';

class NewRegexProjectViewModel extends ChangeNotifier
  implements CodableViewmodelInterface{
  RegexProjectRepository regexProjectRepository = RegexProjectRepository();

  Map<String, String> schema = {
    "name": "project name",
    "author": "writer name or team name",
    "regex": "put the regex rule here to detect column data",
  };

  String code = "return value";

  void addNewRegexProject(Map<String, String> data) {
    data["code"] = this.code;
    print(data.toString());
    regexProjectRepository.remoteDataSource.newRegexProjectByMap(data);
  }

  @override
  void setCode(String code) {
    this.code = code;
    notifyListeners();
  }

  void setCodeDefault() {
    this.code = "return value";
  }
}