import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:admin/viewmodels/interfaces/table_viewmodel_interface.dart';
import 'package:flutter/material.dart';

class MainScreenViewModel extends ChangeNotifier {
  // 메인 대시보드에 뭐가 보일 지 정하게 하는 state
  Screen dashboardScreen = Screen.data;


  TableViewModelInterface selectedDataTableViewModel = SelectedDataTableViewModel(
      DataProjectDto.getColumnList(), []
  );


  void setScreen(Screen screen) {
    dashboardScreen = screen;
    notifyListeners();
  }

  void setSelectedData(DataProjectDto dto) {
    selectedDataTableViewModel.tableDataList = <Map<String, dynamic>>[dto.toJson()];
    dashboardScreen = Screen.dataPreview;
    notifyListeners();
  }

}

enum Screen { data, regex, cleanse, settings, dataPreview, regexPreview }

class SelectedDataTableViewModel implements TableViewModelInterface{

  List<String> _tableColumnList;
  List<Map<String, dynamic>> tableDataList;

  SelectedDataTableViewModel(this._tableColumnList, this.tableDataList);

  @override
  List<Map<String, dynamic>> getTableDataList() {
    return tableDataList;
  }

  @override
  List<String> get tableColumnList => _tableColumnList;

  @override
  void onRowTap(int index) {
   // NOTHING
  }

}
