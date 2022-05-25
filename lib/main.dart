import 'package:admin/constants.dart';
import 'package:admin/repositories/auto_cleansing_repository.dart';
import 'package:admin/repositories/data_project_repository.dart';
import 'package:admin/repositories/regex_project_repository.dart';
import 'package:admin/viewmodels/auto_detection_viewmodel.dart';
import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:admin/viewmodels/main_screen_viewmodel.dart';
import 'package:admin/viewmodels/menu_viewmodel.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/viewmodels/new_data_project_viewmodel.dart';
import 'package:admin/viewmodels/new_regex_project_viewmodel.dart';
import 'package:admin/viewmodels/regex_project_viewmodel.dart';
import 'package:admin/viewmodels/selected_data_head_table_viewmodel.dart';
import 'package:admin/viewmodels/selected_data_table_viewmodel.dart';
import 'package:admin/viewmodels/selected_regex_table_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

final RouteObserver<Route> routeObserver = RouteObserver<Route>();

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xarvis? no Xariviups',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuProvider(),
          ),
          ChangeNotifierProvider(
              create: (context) => MainScreenViewModel()
          ),
          ChangeNotifierProvider(
              create: (context) => DataProjectViewModel(
                  DataProjectRepository()
              )
          ),
          ChangeNotifierProvider(
              create: (context) => SelectedDataTableViewModel()
          ),
          ChangeNotifierProvider(
              create: (context) => SelectedDataHeadTableViewModel(
                  DataProjectRepository()
              )
          ),
          ChangeNotifierProvider(
              create: (context) => NewDataProjectViewModel()
          ),
          ChangeNotifierProvider(
              create: (context) => NewRegexProjectViewModel()
          ),
          ChangeNotifierProvider(
              create: (context) => RegexProjectViewModel(
                  RegexProjectRepository()
              )
          ),
          ChangeNotifierProvider(
              create: (context) => SelectedRegexTableViewModel()
          ),
          ChangeNotifierProvider(
              create: (context) => AutoDetectionViewModel(
                AutoCleansingRepository()
              )
          ),
        ],
        child: MainScreen(),
      ),
    );
  }
}
