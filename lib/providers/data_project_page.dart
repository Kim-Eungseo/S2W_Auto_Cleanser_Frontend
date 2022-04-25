import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/dashboard/views/data_project_view.dart';

class DataProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DataProjectViewModel(),
      child: DataProjectView(),
    );
  }
}