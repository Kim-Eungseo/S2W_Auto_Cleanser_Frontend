import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/detected_columns.dart';
import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:admin/viewmodels/interfaces/search_field_viewmodel_interface.dart';
import 'package:admin/viewmodels/interfaces/table_viewmodel_interface.dart';
import 'package:admin/viewmodels/main_screen_viewmodel.dart';
import 'package:admin/viewmodels/regex_project_viewmodel.dart';
import 'package:admin/viewmodels/selected_data_head_table_viewmodel.dart';
import 'package:admin/viewmodels/selected_data_table_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../viewmodels/selected_regex_table_viewmodel.dart';
import '../components/header.dart';

import '../components/project_search_field.dart';
import '../components/table_view.dart';
import '../components/server_details.dart';
import '../components/text_search_field.dart';

class RegexProjectView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final RegexProjectViewModel viewModel = Provider.of<RegexProjectViewModel>(context);
    final SelectedRegexTableViewModel selectedTableViewModel = Provider.of<SelectedRegexTableViewModel>
      (context, listen: false);


    return SafeArea(
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
                        searchFieldTitle: "Regex Project Search",
                        viewModel: viewModel,
                        hintText: "Type Regex Project Name Here.",
                      ),
                      SizedBox(height: defaultPadding),
                      // MyFiles(),
                      // SizedBox(height: defaultPadding),
                      TableView(
                        title: "Projects",
                        viewModel: viewModel,
                        onRowTap: (map) {
                          Provider.of<MainScreenViewModel>(context, listen: false).isLoading = true;
                          selectedTableViewModel.setSelectedData(map);
                          Provider.of<MainScreenViewModel>(context, listen: false)
                              .setScreen(Screen.regexPreview);
                          Provider.of<MainScreenViewModel>(context, listen: false).isLoading = false;
                        },
                        isButton: true,
                        onButtonTap: () {Provider.of<MainScreenViewModel>(context, listen: false)
                            .setScreen(Screen.newRegexProject);},
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
    );
  }
}

