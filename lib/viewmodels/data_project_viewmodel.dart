import 'package:flutter/cupertino.dart';

class DataProjectViewModel with ChangeNotifier {
  List<DataProjectDto> get dataList => _dataList;
  List<DataProjectDto> _dataList = [];

  DataProjectPreview get preview => _preview;
  late DataProjectPreview _preview;
  
}

class DataProjectDto {
  late int id;
  String name;
  String author;
  String fileText;

  DataProjectDto(this.name, this.author, this.fileText);
}

class DataProjectPreview {
  String name;
  String author;
  String timestamp;
  Map head;

  DataProjectPreview(this.name, this.author, this.timestamp, this.head);
}