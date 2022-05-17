import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/my_regex.dart';
import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:admin/viewmodels/interfaces/search_field_viewmodel_interface.dart';
import 'package:admin/viewmodels/interfaces/table_viewmodel_interface.dart';
import 'package:admin/viewmodels/new_data_project_viewmodel.dart';
import 'package:admin/viewmodels/selected_data_table_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../viewmodels/main_screen_viewmodel.dart';
import '../../../viewmodels/selected_data_head_table_viewmodel.dart';
import '../components/header.dart';

import '../components/table_view.dart';
import '../components/storage_details.dart';
import '../components/text_search_field.dart';

class NewDataProjectView extends StatefulWidget {
  const NewDataProjectView(
      {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewDataProjectView();

}

class _NewDataProjectView extends State<NewDataProjectView> {


  @override
  void initState() {
    super.initState();
  }

  // const _NewDataProjectView({
  //   Key? key
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewDataProjectViewModel viewModel
    = Provider.of<NewDataProjectViewModel>(context);

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
                                  .setScreen(Screen.data);
                            },
                            icon: Icon(Icons.arrow_back),
                            label: Text("Go back to search"),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                      NewProjectContainerView(viewModel),
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

class NewProjectContainerView extends StatefulWidget {
  final NewDataProjectViewModel viewModel;
  NewProjectContainerView(this.viewModel);

  @override
  State<StatefulWidget> createState() => _NewProjectContainerView();

}

class _NewProjectContainerView extends State<NewProjectContainerView> {

  NewDataProjectViewModel? viewModel;
  Map<String, String> newData = {};

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      child: Container(
        height: 400,
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Add New Data Project", style: Theme.of(context).textTheme.subtitle1),
                    Spacer(),
                    ElevatedButton.icon(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding * 1.5,
                          vertical:
                          defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                        ),
                      ),
                      onPressed: () {
                        viewModel!.addNewDataProject(newData);
                      },
                      icon: Icon(Icons.add),
                      label: Text("Submit"),
                    ),
                  ]
              ),
              for (String s in viewModel!.schema.keys)
              Expanded(
                child: Row(
                  children: [
                   SizedBox(width: defaultPadding),
                   Expanded(
                       child: Text(s , style: Theme.of(context).textTheme.subtitle1)
                   ),
                    Expanded(
                       flex: 4,
                       child: TextField(
                       onChanged: (text) {
                         newData[s] = text;
                         print(newData);
                       },
                       decoration: InputDecoration(
                         hintText: viewModel!.schema[s],
                         fillColor: secondaryColor,
                         filled: true,
                         border: OutlineInputBorder(
                             borderSide: BorderSide.none,
                             borderRadius: const BorderRadius.all(Radius.circular(10))
                         ),
                       ),
                     ),
                   ),
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}