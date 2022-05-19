import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:admin/viewmodels/interfaces/table_viewmodel_interface.dart';
import 'package:flutter/material.dart';

class MainScreenViewModel extends ChangeNotifier {
  // 메인 대시보드에 뭐가 보일 지 정하게 하는 state
  Screen dashboardScreen = Screen.data;

  void setScreen(Screen screen) {
    dashboardScreen = screen;
    notifyListeners();
  }
}

enum Screen { data, regex, cleanse, settings,
  dataPreview, regexPreview, newDataProject, newRegexProject }


