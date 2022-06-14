import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/detected_columns.dart';
import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:admin/viewmodels/interfaces/search_field_viewmodel_interface.dart';
import 'package:admin/viewmodels/interfaces/table_viewmodel_interface.dart';
import 'package:admin/viewmodels/new_data_project_viewmodel.dart';
import 'package:admin/viewmodels/selected_data_table_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:provider/provider.dart';

import 'dart:convert';

import '../../../constants.dart';
import '../../../viewmodels/main_screen_viewmodel.dart';
import '../../../viewmodels/selected_data_head_table_viewmodel.dart';
import '../components/header.dart';

import '../components/table_view.dart';
import '../components/server_details.dart';
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

  void setFileData(String data) {
    setState(() {
    });
  }

  late DropzoneViewController controller1;
  String message1 = 'Drop data file at here';
  bool highlighted1 = false;
  // const _NewDataProjectView({
  //   Key? key
  // }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final NewDataProjectViewModel viewModel
    = Provider.of<NewDataProjectViewModel>(context);

    NewProjectContainerView newProjectContainerView = NewProjectContainerView(
      viewModel: viewModel,
    );

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
                  flex: 3,
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
                      newProjectContainerView,
                      SizedBox(height: defaultPadding),
                      Container(
                        padding: EdgeInsets.all(defaultPadding),
                        decoration: BoxDecoration(
                          color: highlighted1 ? tertiaryColor: bgColor,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
                        ),
                        height: 400,
                        child: Stack(
                            children: [
                              DropzoneView(
                                operation: DragOperation.copy,
                                cursor: CursorType.grab,
                                onCreated: (ctrl) => controller1 = ctrl,
                                onLoaded: () => print('Zone 1 loaded'),
                                onError: (ev) => print('Zone 1 error: $ev'),
                                onHover: () {
                                  setState(() => highlighted1 = true);
                                  print('Zone 1 hovered');
                                },
                                onLeave: () {
                                  setState(() => highlighted1 = false);
                                  print('Zone 1 left');
                                },
                                onDrop: (ev) async {
                                  print('Zone 1 drop: ${ev.name}');
                                  setState(() {
                                    message1 = '${ev.name} dropped.\n You no need to fill the file text field';
                                    highlighted1 = false;
                                  });
                                  final bytes = await controller1.getFileData(ev);
                                  Provider.of<NewDataProjectViewModel>(context , listen: false).uploadedText = utf8.decode(bytes);

                                },
                                onDropMultiple: (ev) async {
                                  print('Zone 1 drop multiple: $ev');
                                },
                              ),
                              Center(child: Text(message1)),
                              ]
                            ),

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

class NewProjectContainerView extends StatefulWidget {
  final NewDataProjectViewModel? viewModel;

  NewProjectContainerView({
    this.viewModel,
  });

  @override
  State<StatefulWidget> createState() => _NewProjectContainerView();

}

class _NewProjectContainerView extends State<NewProjectContainerView> {

  NewDataProjectViewModel? viewModel;
  Map<String, String> newData = {};
  bool isOn = false;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
    print(newData["file_text"]);
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
          boxShadow: [
            BoxShadow(
              color: tertiaryColor.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
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
                        print("onpressed");
                        viewModel!.addNewDataProject(newData);
                        Provider.of<MainScreenViewModel>(context, listen: false)
                            .setScreen(Screen.data);
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
                         keyboardType: TextInputType.multiline,
                         maxLines: null,
                         onChanged: (text) {
                           newData[s] = text;
                           print(newData.toString());
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
              ),

            ],
          )
      ),
    );
  }
}