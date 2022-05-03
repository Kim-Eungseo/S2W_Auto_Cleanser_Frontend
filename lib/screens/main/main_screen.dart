import 'package:admin/screens/dashboard/views/data_project_view.dart';
import 'package:admin/viewmodels/main_screen_viewmodel.dart';
import 'package:admin/viewmodels/menu_viewmodel.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/views/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuProvider>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Consumer<MainScreenViewModel>(
                builder: (context, mainScreen, child) {
                  switch (mainScreen.dashboardScreen) {
                    case Screen.data:
                      return DataProjectView();
                    case Screen.regex:
                      return DashboardView();
                    case Screen.cleanse:
                      return DashboardView();
                    case Screen.settings:
                      return DashboardView();
                    case Screen.dataPreview:
                      return DashboardView();
                    case Screen.regexPreview:
                      return DashboardView();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


}
