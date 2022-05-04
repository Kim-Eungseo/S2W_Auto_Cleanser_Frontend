import 'package:admin/constants.dart';
import 'package:admin/repositories/data_project_repository.dart';
import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:admin/viewmodels/main_screen_viewmodel.dart';
import 'package:admin/viewmodels/menu_viewmodel.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/viewmodels/selected_data_head_viewmodel.dart';
import 'package:admin/viewmodels/selected_data_viewmodel.dart';
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
        ],
        child: MainScreen(),
      ),
    );
  }
}
