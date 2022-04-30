class TableViewModel {
  List<String> _tableColumnList;
  List<Map<String, dynamic>> _tableDataList;
  TableViewModel(this._tableColumnList, this._tableDataList);
  List<String> getTableColumnList() {return _tableColumnList;}
  List<Map<String, dynamic>> getTableDataList() {return _tableDataList;}
}