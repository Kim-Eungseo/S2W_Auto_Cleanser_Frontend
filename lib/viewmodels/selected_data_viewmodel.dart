import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'interfaces/table_viewmodel_interface.dart';

class SelectedDataTableViewModel extends ChangeNotifier
    implements TableViewModelInterface{

  List<String> _tableColumnList = DataProjectDto.getColumnList();
  List<Map<String, dynamic>> tableDataList = [];

  @override
  List<Map<String, dynamic>> getTableDataList() {
    return tableDataList;
  }

  @override
  List<String> get tableColumnList => _tableColumnList;

  void setSelectedData(Map<String, dynamic> data) {
    tableDataList = <Map<String, dynamic>>[data];
  }

  void notify() {
    notifyListeners();
  }

}