import 'package:admin/screens/dashboard/components/flow_button.dart';
import 'package:admin/screens/dashboard/components/table_view.dart';
import 'package:admin/viewmodels/data_cleansing_viewmodel.dart';
import 'package:admin/viewmodels/main_screen_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../responsive.dart';
import '../../../viewmodels/auto_detection_viewmodel.dart';
import '../components/header.dart';
import '../components/detected_columns.dart';
import '../components/server_details.dart';

class CleansingProcessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DataCleansingViewModel viewModel = Provider.of<DataCleansingViewModel>(context);
    final AutoDetectionViewModel detectionViewModel = Provider.of<AutoDetectionViewModel>(context);
    final MainScreenViewModel mainScreenViewModel = Provider.of<MainScreenViewModel>(context, listen: false);


    return SafeArea(
      child: SingleChildScrollView(
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (!Responsive.isMobile(context))
                              Text(
                              "Cleaning Process Selection",
                              overflow: TextOverflow.ellipsis,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1,
                              ),
                            if (Responsive.isMobile(context))
                              Text(
                                "Select Process",
                                overflow: TextOverflow.ellipsis,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1,
                              ),
                              Spacer(),
                            if (detectionViewModel.tableDataList.length != 0)
                              FlowButton(
                                  onPressed: () {
                                    if (detectionViewModel.tableDataList.length > 0){
                                      mainScreenViewModel.isLoading = true;
                                      viewModel.cleanse();
                                      mainScreenViewModel.isLoading = false;
                                    }
                                  },
                                  icon: Icon(Icons.cleaning_services_rounded),
                                  label: Text("Cleanse!"),
                              ),
                            if (detectionViewModel.tableDataList.length == 0)
                              FlowButton(
                                onPressed: () {
                                  Provider.of<MainScreenViewModel>(context, listen: false)
                                      .setScreen(Screen.data);
                                },
                                icon: Icon(Icons.arrow_back),
                                label: Text("Go set process"),
                              )

                          ]
                      ),
                      SizedBox(height: defaultPadding),
                      // HERE I NEED SELECTED CLEAN PROCESS
                      if (detectionViewModel.tableDataList.length == 0)
                        Text(
                          "You first need to select column detects"
                        ),
                      Column(
                        children: [
                          for (int i = 0; i < detectionViewModel.tableDataList.length; i++)
                            Container(
                              child: DetectedColumns(
                                title: detectionViewModel.tableColumnList[i],
                                detectedRegexes: detectionViewModel.tableDataList[i],
                              ),
                            )
                        ],
                      ),
                      Divider(),
                      SizedBox(height: defaultPadding),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Cleansed Data Result",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .subtitle1,
                            ),
                          ]
                      ),
                      SizedBox(height: defaultPadding),
                      TableView(
                        title: "Cleanse Success",
                        viewModel: viewModel.successTableViewModel,
                        isDownload: true,
                      ),
                      SizedBox(height: defaultPadding),
                      TableView(
                        title: "Cleanse Fail",
                        viewModel: viewModel.failTableViewModel,
                        isDownload: true,
                      ),
                      SizedBox(height: defaultPadding),
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