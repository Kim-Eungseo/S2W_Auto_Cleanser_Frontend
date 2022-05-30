import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:admin/viewmodels/interfaces/codable_viewmodel_interface.dart';
import 'package:admin/viewmodels/regex_project_viewmodel.dart';
import 'package:flutter/cupertino.dart';

import 'interfaces/table_viewmodel_interface.dart';

class FailTableViewModel extends ChangeNotifier
    implements TableViewModelInterface{

  List<String> _tableColumnList = ["Me too!"];
  List<Map<String, dynamic>> tableDataList = [];

  @override
  List<Map<String, dynamic>> getTableDataList() {
    return tableDataList;
  }

  @override
  List<String> get tableColumnList => _tableColumnList;

  void setTableData(Map<String, dynamic> data) {
    tableDataList = [];
    _tableColumnList = data.keys.toList();
    int rowLength = (data[_tableColumnList[0]] as List).length;

    // guard clause
    if (_tableColumnList.isEmpty ||
         rowLength == 0) {
      // send error!
      return;
    }

    for (int i = 0; i < rowLength; i++) {
      Map<String, dynamic> row = {};
      for (String colName in _tableColumnList) {
        row[colName] = data[colName][i];
      }
      tableDataList.add(row);
    }
    notify();
  }

  void notify() {
    notifyListeners();
  }

}