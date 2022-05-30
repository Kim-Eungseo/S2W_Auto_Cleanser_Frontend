import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/detected_columns.dart';
import 'package:admin/viewmodels/auto_detection_viewmodel.dart';
import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:admin/viewmodels/interfaces/search_field_viewmodel_interface.dart';
import 'package:admin/viewmodels/interfaces/table_viewmodel_interface.dart';
import 'package:admin/viewmodels/main_screen_viewmodel.dart';
import 'package:admin/viewmodels/selected_data_head_table_viewmodel.dart';
import 'package:admin/viewmodels/selected_data_table_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../components/header.dart';

import '../components/project_search_field.dart';
import '../components/table_view.dart';
import '../components/server_details.dart';
import '../components/text_search_field.dart';

class DataProjectView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final DataProjectViewModel viewModel = Provider.of<DataProjectViewModel>(context);
    final SelectedDataTableViewModel selectedTableViewModel = Provider.of<SelectedDataTableViewModel>
      (context, listen: false);
    final SelectedDataHeadTableViewModel selectedHeadTableViewModel =
    Provider.of<SelectedDataHeadTableViewModel>(context, listen: false);
    final AutoDetectionViewModel detectionViewModel =
    Provider.of<AutoDetectionViewModel>(context, listen: false);

    return SafeArea(
      child: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        ProjectSearchField(
                          searchFieldTitle: "Data Project Search",
                          viewModel: viewModel,
                          hintText: "Type Data Project Name Here.",
                        ),
                        SizedBox(height: defaultPadding),
                        // MyFiles(),
                        // SizedBox(height: defaultPadding),
                        TableView(
                          title: "Projects",
                          viewModel: viewModel,
                          onRowTap: (map) {
                            selectedHeadTableViewModel.searchById(map['id'] as int);
                            detectionViewModel.tableColumnList = selectedHeadTableViewModel.tableColumnList;
                            selectedTableViewModel.setSelectedData(map);
                            Provider.of<AutoDetectionViewModel>(context, listen: false).initView();
                            Provider.of<MainScreenViewModel>(context, listen: false)
                            .setScreen(Screen.dataPreview);
                          },
                          isButton: true,
                          onButtonTap: () {Provider.of<MainScreenViewModel>(context, listen: false)
                              .setScreen(Screen.newDataProject);},
                          ),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context))
                          ServerDetails(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we dont want to show it
                  if (!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: ServerDetails(),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

