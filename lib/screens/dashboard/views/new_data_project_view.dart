import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/my_regex.dart';
import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:admin/viewmodels/interfaces/search_field_viewmodel_interface.dart';
import 'package:admin/viewmodels/interfaces/table_viewmodel_interface.dart';
import 'package:admin/viewmodels/new_data_project_viewmodel.dart';
import 'package:admin/viewmodels/selected_data_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../viewmodels/main_screen_viewmodel.dart';
import '../../../viewmodels/selected_data_head_viewmodel.dart';
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
    viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (String s in viewModel!.schema.keys)
            Column(
              children: [
               Flexible(
                   child: Text(s)
               ),
                Flexible(
                   flex: 3,
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
            )
          ],
        )
    );
  }
}