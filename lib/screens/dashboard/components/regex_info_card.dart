import 'dart:html';

import 'package:admin/models/MyRegex.dart';
import 'package:admin/viewmodels/regex_project_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../viewmodels/data_cleansing_viewmodel.dart';
import '../../../viewmodels/main_screen_viewmodel.dart';
import '../../../viewmodels/selected_regex_table_viewmodel.dart';

class RegexInfoCard extends StatefulWidget {
  final RegexProjectDto info;
  final int number;
  final String title;

  const RegexInfoCard({
    Key? key,
    required this.info,
    required this.number,
    required this.title
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegexInfoCard();

}

class _RegexInfoCard extends State<RegexInfoCard> {

  RegexProjectDto? info;
  int? number;
  String? title;

  @override
  void initState() {
    super.initState();
    this.info = widget.info;
    this.number = widget.number;
    this.title = widget.title;
  }

  @override
  Widget build(BuildContext context) {

    final SelectedRegexTableViewModel viewModel
    = Provider.of<SelectedRegexTableViewModel>(context, listen: false);
    final DataCleansingViewModel cleansingViewModel
    = Provider.of<DataCleansingViewModel>(context, listen: false);
    // GridIndexViewModel indexViewModel = Provider.of<GridIndexViewModel>(context, listen: false);


    // return Consumer<GridIndexViewModel>(builder: (context, grid, child){
      return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: number! == cleansingViewModel.selectedIndexes[title!] ? tertiaryColor : secondaryColor,
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
        child: InkWell(
          onTap: () {
            setState(() {
              if(number! == cleansingViewModel.selectedIndexes[title!]){
                cleansingViewModel.selectedIndexes[title!] = -1;
                cleansingViewModel.process.remove(
                    CleansingProcessDto(col_name: title!, regex_id: this.info!.id)
                );
                cleansingViewModel.notify();
              } else {
                cleansingViewModel.selectedIndexes[title!] = number!;
                cleansingViewModel.process.add(
                    CleansingProcessDto(col_name: title!, regex_id: this.info!.id)
                );
                print("added");
                cleansingViewModel.notify();
              }
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    info!.name ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white70),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  InkWell(
                      onTap: () {
                        viewModel.isFromAutoDetection = true;
                        viewModel.setSelectedData(info!.toJson());
                        Provider.of<MainScreenViewModel>(context, listen: false)
                            .setScreen(Screen.regexPreview);
                      },
                      child: Icon(Icons.info, color: Colors.white54)
                  )
                ],
              ),
              Text(
                info!.regex ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white60),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              ProgressLine(percentage: 10),
              Text(
                info!.timestamp ?? "",
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.white60),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    info!.author ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.white70),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  if (number! == cleansingViewModel.selectedIndexes[title!])
                    InkWell(
                        onTap: () {
                          setState(() {
                            cleansingViewModel.selectedIndexes[title!] = -1;
                            cleansingViewModel.notify();
                          });
                        },
                        child: Icon(Icons.check, color: Colors.red,)
                    )
                ],
              ),
            ],
          ),
        ),
      );
    // });
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * ((percentage! > 100 ? 100 : percentage!) / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
