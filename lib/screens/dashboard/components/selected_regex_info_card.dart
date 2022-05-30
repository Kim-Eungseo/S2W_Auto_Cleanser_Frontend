import 'dart:html';

import 'package:admin/models/MyRegex.dart';
import 'package:admin/viewmodels/regex_project_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../viewmodels/main_screen_viewmodel.dart';
import '../../../viewmodels/selected_regex_table_viewmodel.dart';

class SelectedRegexInfoCard extends StatefulWidget {
  final RegexProjectDto info;

  const SelectedRegexInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectedRegexInfoCard();

}

class _SelectedRegexInfoCard extends State<SelectedRegexInfoCard> {

  RegexProjectDto? info;

  @override
  void initState() {
    super.initState();
    this.info = widget.info;
  }

  @override
  Widget build(BuildContext context) {

    final SelectedRegexTableViewModel viewModel
    = Provider.of<SelectedRegexTableViewModel>(context, listen: false);

    return InkWell(
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
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
            Text(
              info!.author ?? "",
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.white70),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
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
