import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/my_regex.dart';
import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:admin/viewmodels/interfaces/search_field_viewmodel_interface.dart';
import 'package:admin/viewmodels/interfaces/table_viewmodel_interface.dart';
import 'package:admin/viewmodels/selected_data_table_viewmodel.dart';
import 'package:admin/viewmodels/selected_regex_table_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../viewmodels/main_screen_viewmodel.dart';
import '../../../viewmodels/regex_project_viewmodel.dart';
import '../../../viewmodels/selected_data_head_table_viewmodel.dart';
import '../components/code_editor/editor.dart';
import '../components/header.dart';

import '../components/table_view.dart';
import '../components/storage_details.dart';
import '../components/text_search_field.dart';

class SelectedRegexProjectView extends StatelessWidget {

  const SelectedRegexProjectView({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegexProjectViewModel viewModel = Provider.of<RegexProjectViewModel>(context);
    final TableViewModelInterface regexPreviewModel = Provider.of<SelectedRegexTableViewModel>(context);


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
                      Row(
                        children: [
                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical:
                                defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                              ),
                            ),
                            onPressed: () {
                              Provider.of<MainScreenViewModel>(context, listen: false)
                                  .setScreen(Screen.regex);
                            },
                            icon: Icon(Icons.arrow_back),
                            label: Text("Go back to search"),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                      Consumer<MainScreenViewModel>(
                          builder: (context, mainScreen, child) {
                            return TableView(
                              title: "Project Info",
                              viewModel: regexPreviewModel,
                            );
                          }),
                      SizedBox(height: defaultPadding),
                      Editor(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context))
                        StorageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StorageDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DataProjectSearchField extends StatefulWidget{
  final String? searchFieldTitle;
  final SearchFieldViewModelInterface? viewModel;

  const DataProjectSearchField({
    Key? key,
    this.searchFieldTitle,
    this.viewModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DataProjectSearchField();
}

class _DataProjectSearchField extends State<DataProjectSearchField>{
  String? searchFieldTitle;
  SearchFieldViewModelInterface? viewModel;

  // const _DataProjectSearchField({
  //   Key? key,
  //   this.searchFieldTitle,
  //   this.viewModel,
  // }) : super(key: key);

  @override
  void initState(){
    super.initState();
    this.searchFieldTitle = widget.searchFieldTitle;
    this.viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          searchFieldTitle!,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(width: defaultPadding * 2),
        Expanded(
          child: ContentSearchFieldView(
            hintText: "Type Data Project Name Here.",
            viewModel: viewModel,
          ),
        ),
      ],
    );
  }

}
