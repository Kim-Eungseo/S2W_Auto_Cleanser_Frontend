import 'dart:convert';

import 'package:admin/repositories/auto_cleansing_repository.dart';
import 'package:admin/viewmodels/fail_table_viewmodel.dart';
import 'package:admin/viewmodels/success_table_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_cleansing_viewmodel.g.dart';

class DataCleansingViewModel with ChangeNotifier{
  AutoCleansingRepository cleansingRepository;
  SuccessTableViewModel successTableViewModel;
  FailTableViewModel failTableViewModel;

  String? projectId;
  List<CleansingProcessDto> process = [];

  Map<String, int> selectedIndexes = {};
  int selectedIndex = -1;

  List<String> _tableColumnList = ["not set yet"];

  set tableColumnList(List<String> value) {
    _tableColumnList = value;
    notifyListeners();
  }

  List<List> tableDataList = [];

  @override
  List<String> get tableColumnList => _tableColumnList;

  DataCleansingViewModel(
      this.cleansingRepository,
      this.successTableViewModel,
      this.failTableViewModel
      );

  void setCleansingResult(Map<String, dynamic> res) {
    successTableViewModel.setTableData(res["success_df"] as Map<String, dynamic>);
    failTableViewModel.setTableData(res["fail_df"] as Map<String, dynamic>);
  }

  void addColDataCleansing(CleansingProcessDto dto) => process.add(dto);

  void cleanse() async{
    Map<String, dynamic> data = {};
    data["project_id"] = projectId ?? "";
    data["process"] = process.map((e) {
      return e.toJson();
    }).toList();

    Future<Map<String, dynamic>> res = cleansingRepository
        .remoteDataSource
        .cleanseData(jsonEncode(data));

    await res.then((value) {
      setCleansingResult(value);
    }).whenComplete(() {
      notifyListeners();
    });

    // init process
    process = [];
    return;
  }


  void notify() {
    notifyListeners();
  }
}

// 아 이건 camelCase가 아님을 용서해주십시오 흑흑
@JsonSerializable()
class CleansingProcessDto {
  // ignore: non_constant_identifier_names
  final String? col_name;
  // ignore: non_constant_identifier_names
  final String? regex_id;

  CleansingProcessDto({
    // ignore: non_constant_identifier_names
    required this.col_name,
    // ignore: non_constant_identifier_names
    required this.regex_id,
  });

  factory CleansingProcessDto.fromJson(Map<String, dynamic> json) =>
      _$CleansingProcessDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CleansingProcessDtoToJson(this);

  @override
  String toString() {
    return 'CleansingProcessDto{colName: $col_name, regexId: $regex_id}';
  }
}
