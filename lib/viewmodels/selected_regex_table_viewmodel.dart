import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:admin/viewmodels/interfaces/codable_viewmodel_interface.dart';
import 'package:admin/viewmodels/regex_project_viewmodel.dart';
import 'package:flutter/cupertino.dart';

import 'interfaces/table_viewmodel_interface.dart';

class SelectedRegexTableViewModel extends ChangeNotifier
    implements TableViewModelInterface, CodableViewmodelInterface{

  List<String> _tableColumnList = RegexProjectDto.getColumnList();
  List<Map<String, dynamic>> tableDataList = [];
  String code = "";
  List<String> lines = <String>[''];

  @override
  List<Map<String, dynamic>> getTableDataList() {
    return tableDataList;
  }

  @override
  List<String> get tableColumnList => _tableColumnList;

  void setSelectedData(Map<String, dynamic> data) {
    tableDataList = <Map<String, dynamic>>[data];
    code = tableDataList[0]["code"];
  }

  void setCode(String code) {
    this.code = code;
    this.tableDataList[0]["code"] = code;
    notify();
  }

  void saveCode() {
    this.tableDataList[0]["code"] = this.code;
    notify();
  }

  void notify() {
    notifyListeners();
  }

}