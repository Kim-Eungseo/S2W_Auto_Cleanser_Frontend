import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/detected_columns.dart';
import 'package:admin/screens/dashboard/components/flow_button.dart';
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
import '../components/code_editor.dart';
import '../components/code_editor/editor.dart';
import '../components/header.dart';

import '../components/table_view.dart';
import '../components/server_details.dart';
import '../components/text_search_field.dart';

class SelectedRegexProjectView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  SelectedRegexProjectView({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegexProjectViewModel viewModel = Provider.of<RegexProjectViewModel>(context);
    final SelectedRegexTableViewModel regexPreviewModel = Provider.of<SelectedRegexTableViewModel>(context);


    return SafeArea(
      child: SingleChildScrollView(
        controller: _scrollController,
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
                  flex: 3,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          if (regexPreviewModel.isFromAutoDetection == false)
                            FlowButton(
                              onPressed: () {
                                Provider.of<MainScreenViewModel>(context, listen: false)
                                    .setScreen(Screen.regex);
                              },
                              icon: Icon(Icons.arrow_back),
                              label: Text("Go back to search"),
                            ),
                          if(regexPreviewModel.isFromAutoDetection)
                            FlowButton(
                                onPressed: () {
                                  regexPreviewModel.isFromAutoDetection = false;
                                  Provider.of<MainScreenViewModel>(context, listen: false)
                                      .setScreen(Screen.dataPreview);
                                },
                                icon: Icon(Icons.arrow_back),
                                label: Text("Go back to auto-detect")
                            ),
                          Spacer(),
                          FlowButton(
                            onPressed: () {
                              viewModel.tableDataList.remove(regexPreviewModel.tableDataList[0]);
                              viewModel.delete(regexPreviewModel.tableDataList[0]['id']);
                              Provider.of<MainScreenViewModel>(context, listen: false)
                                  .setScreen(Screen.regex);
                            },
                            icon: Icon(Icons.delete), label: Text("delete"),
                          ),
                          SizedBox(width: defaultPadding),

                          FlowButton(
                            onPressed: () {
                              regexPreviewModel.saveCode();
                              viewModel.tableDataList.remove(regexPreviewModel.tableDataList[0]);
                              viewModel.update(regexPreviewModel.tableDataList[0]);
                              Provider.of<MainScreenViewModel>(context, listen: false)
                                  .setScreen(Screen.regex);
                            },
                            icon: Icon(Icons.update), label: Text("update"),
                          ),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                      Consumer<MainScreenViewModel>(
                          builder: (context, mainScreen, child) {
                            return TableView(
                              title: "Regex Info",
                              viewModel: regexPreviewModel,
                            );
                          }),
                      SizedBox(height: defaultPadding),
                      // Editor(codableViewmodel: Provider.of<SelectedRegexTableViewModel>(context, listen: false),),
                      CodeEditor(context.read<SelectedRegexTableViewModel>()),

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
                    flex: 1,
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
