import 'package:admin/models/MyRegex.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/selected_regex_info_card.dart';
import 'package:admin/screens/dashboard/components/text_search_field.dart';
import 'package:admin/viewmodels/regex_project_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'regex_info_card.dart';

class SelectedProcesses extends StatelessWidget {
  final String? title;
  final List? selectedRegexes;

  const SelectedProcesses({
    Key? key,
    this.title,
    this.selectedRegexes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (title ?? "Title error, restore the state."),
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(width: defaultPadding * 2),
            // Expanded(
            //   child: ProjectSearchField(),
            // ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  selectedRegexes!.length != 0 ? "selected regex cleansing projects" : "No selected regex cleansing projects",
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white60
                  )
              ),
            ]
        ),
        SizedBox(height: defaultPadding / 2),
        Responsive(
          mobile: RegexInfoCardGridView(
            detectedRegexes: selectedRegexes,
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: RegexInfoCardGridView(
            detectedRegexes: selectedRegexes,
          ),
          desktop: RegexInfoCardGridView(
            detectedRegexes: selectedRegexes,
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
        SizedBox(height: defaultPadding,)
      ],
    );
  }
}

class RegexInfoCardGridView extends StatelessWidget {
  const RegexInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.detectedRegexes,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  final List? detectedRegexes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: (detectedRegexes ?? []).length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => SelectedRegexInfoCard(info: detectedRegexes![index] as RegexProjectDto),
    );
  }
}



