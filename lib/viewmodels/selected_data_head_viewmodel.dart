import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    Future<DataProjectDto> data = dataProjectRepository
        .remoteDataSource
        .getDataProjectById(id);

    await data.then((unfuturedData) {
      Map<String, dynamic> head = unfuturedData.head!;
      this.tableColumnList = head.keys.toList();
      print(head.toString());

      List<Map<String, dynamic>> dataList = [];

      for (int i = 0; i < (head[this.tableColumnList[0]] as List).length; i++){
        dataList.add(
            Map<String, dynamic>.fromIterables(
            this.tableColumnList, this.tableColumnList
            .map((value) => head[value]![i])
        )
        );
      }
      tableDataList = dataList;
    }).whenComplete(() {
      notifyListeners();
    });
  }

}