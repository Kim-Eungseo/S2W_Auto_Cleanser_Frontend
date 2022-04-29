import 'package:flutter/cupertino.dart';

class MainScreenViewModel extends ChangeNotifier {
  // 메인 대시보드에 뭐가 보일 지 정하게 하는 state
  Screen dashboardScreen = Screen.regex;

  void setScreen(Screen screen) {
    dashboardScreen = screen;
    notifyListeners();
  }
}

enum Screen { data, regex, cleanse, settings }