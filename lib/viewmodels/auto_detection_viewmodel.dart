import 'package:admin/repositories/auto_cleansing_repository.dart';
import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:admin/viewmodels/regex_project_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'interfaces/table_viewmodel_interface.dart';

class AutoDetectionViewModel extends ChangeNotifier {

  AutoCleansingRepository cleansingRepository;

  AutoDetectionViewModel(this.cleansingRepository);

  List<String> _tableColumnList = ["not set yet"];

  set tableColumnList(List<String> value) {
    _tableColumnList = value;
    notify();
  }

  List<List> tableDataList = [];

  @override
  List<String> get tableColumnList => _tableColumnList;

  void notify() {
    notifyListeners();
  }

  void getAutoDetection(int id) async{
    Future<Map<String, dynamic>> data = cleansingRepository
        .remoteDataSource
        .getAutoDetectionById(id);

    await data.then((value) {
      tableDataList = [];
      _tableColumnList = [];
      value.forEach((key, value) {
        if ((value as List).length > 0) {
          final data = value.map((e) => RegexProjectDto.fromJson(e as Map<String, dynamic>)).toList();
          tableDataList.add(data);
        } else {
          tableDataList.add([]);
        }
        _tableColumnList.add(key);
      });
    }).whenComplete(() {
      notifyListeners();
    });
  }

}