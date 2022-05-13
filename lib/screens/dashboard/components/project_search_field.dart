import 'package:admin/screens/dashboard/components/text_search_field.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../viewmodels/interfaces/search_field_viewmodel_interface.dart';

class ProjectSearchField extends StatefulWidget{
  final String? searchFieldTitle;
  final SearchFieldViewModelInterface? viewModel;
  final String? hintText;

  const ProjectSearchField({
    Key? key,
    this.searchFieldTitle,
    this.viewModel,
    this.hintText,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProjectSearchField();
}

class _ProjectSearchField extends State<ProjectSearchField> {
  String? searchFieldTitle;
  SearchFieldViewModelInterface? viewModel;
  String? hintText;

  // const _DataProjectSearchField({
  //   Key? key,
  //   this.searchFieldTitle,
  //   this.viewModel,
  // }) : super(key: key);

  @override
  void initState() {
    super.initState();
    this.searchFieldTitle = widget.searchFieldTitle;
    this.viewModel = widget.viewModel;
    this.hintText = widget.hintText;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          searchFieldTitle!,
          style: Theme
              .of(context)
              .textTheme
              .subtitle1,
        ),
        SizedBox(width: defaultPadding * 2),
        Expanded(
          child: ContentSearchFieldView(
            hintText: hintText!,
            viewModel: viewModel,
          ),
        ),
      ],
    );
  }
}