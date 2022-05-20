import 'package:admin/repositories/data_project_repository.dart';
import 'package:flutter/material.dart';

class NewDataProjectViewModel extends ChangeNotifier {
  DataProjectRepository dataProjectRepository = DataProjectRepository();

  Map<String, String> schema = {
    "name": "project name",
    "author": "writer name or team name",
    "file_text": "put the table data text on here, make sure that data shapes like table"
  };

  void addNewDataProject(Map<String, String> data) {
    print(data.toString());
    dataProjectRepository.remoteDataSource.newDataProjectByMap(data);
  }
}