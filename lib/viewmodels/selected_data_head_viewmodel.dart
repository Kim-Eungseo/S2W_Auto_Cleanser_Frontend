import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../repositories/data_project_repository.dart';
import 'interfaces/table_viewmodel_interface.dart';

class SelectedDataHeadTableViewModel extends ChangeNotifier
    implements TableViewModelInterface{

  final DataProjectRepository dataProjectRepository;

  SelectedDataHeadTableViewModel(
    this.dataProjectRepository
  );

  List<String> _tableColumnList = [];

  set tableColumnList(List<String> value) {
    _tableColumnList = value;
  }

  List<Map<String, dynamic>> tableDataList = [];

  @override
  List<Map<String, dynamic>> getTableDataList() {
    return tableDataList;
  }

  @override
  List<String> get tableColumnList => _tableColumnList;

  void setSelectedData(List<Map<String, dynamic>> data) {
    tableDataList = data;
    print("SelectedDataHeadTableViewModel listens");
    notifyListeners();
  }

  void searchById(int id) async{
    Future<DataProjectDto> data = dataProjectRepository!
        .remoteDataSource
        .getDataProjectById(id);

    await data.then((unfuturedData) {
      Map<String, dynamic> head = unfuturedData.head!;
      List<String> colList = head.keys.toList();
      // tableDataList = unfuturedData.head.;

    }).whenComplete(() {
      notifyListeners();
    });
  }

}