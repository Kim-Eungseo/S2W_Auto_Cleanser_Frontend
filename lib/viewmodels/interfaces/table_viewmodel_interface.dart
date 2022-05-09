import 'package:flutter/cupertino.dart';

class TableViewModelInterface {
  List<String> _tableColumnList;
  List<Map<String, dynamic>> tableDataList;

  TableViewModelInterface(this._tableColumnList, this.tableDataList);

  List<String> get tableColumnList => _tableColumnList;
  List<Map<String, dynamic>> getTableDataList() {return tableDataList;}

}