class TableViewModelInterface {
  List<String> _tableColumnList;
  List<Map<String, dynamic>> _tableDataList;

  TableViewModelInterface(this._tableColumnList, this._tableDataList);

  List<String> get tableColumnList => _tableColumnList;
  List<Map<String, dynamic>> getTableDataList() {return _tableDataList;}
}