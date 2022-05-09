import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/my_regex.dart';
import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:admin/viewmodels/interfaces/search_field_viewmodel_interface.dart';
import 'package:admin/viewmodels/interfaces/table_viewmodel_interface.dart';
import 'package:admin/viewmodels/main_screen_viewmodel.dart';
import 'package:admin/viewmodels/selected_data_head_viewmodel.dart';
import 'package:admin/viewmodels/selected_data_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../components/header.dart';

import '../components/table_view.dart';
import '../components/storage_details.dart';
import '../components/text_search_field.dart';

class DataProjectView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final DataProjectViewModel viewModel = Provider.of<DataProjectViewModel>(context);
    final SelectedDataTableViewModel selectedTableViewModel = Provider.of<SelectedDataTableViewModel>
      (context, listen: false);
    final SelectedDataHeadTableViewModel selectedHeadTableViewModel =
    Provider.of<SelectedDataHeadTableViewModel>(context, listen: false);


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
                      DataProjectSearchField(
                        searchFieldTitle: "Data Project Search",
                        viewModel: viewModel,
                      ),
                      SizedBox(height: defaultPadding),
                      // MyFiles(),
                      // SizedBox(height: defaultPadding),
                      TableView(
                        title: "Projects",
                        viewModel: viewModel,
                        onRowTap: (map) {
                          selectedTableViewModel.setSelectedData(map);
                          selectedHeadTableViewModel.searchById(map['id'] as int);
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
          child: ContentSearchField(
            hintText: "Type Data Project Name Here.",
            viewModel: viewModel,
          ),
        ),
      ],
    );
  }

}
