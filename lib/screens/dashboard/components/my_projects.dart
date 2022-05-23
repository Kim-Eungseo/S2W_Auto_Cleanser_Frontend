import 'package:admin/models/MyRegex.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/text_search_field.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'regex_info_card.dart';

class MyProjects extends StatelessWidget {
  const MyProjects({
    Key? key,
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
              "",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(width: defaultPadding * 2),
            // Expanded(
            //   child: ProjectSearchField(),
            // ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: ProjectInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: ProjectInfoCardGridView(),
          desktop: ProjectInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class ProjectInfoCardGridView extends StatelessWidget {
  const ProjectInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyRegex.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => RegexInfoCard(info: demoMyRegex[index]),
    );
  }
}



