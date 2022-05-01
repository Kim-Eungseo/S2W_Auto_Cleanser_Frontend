import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../viewmodels/interfaces/search_field_viewmodel_interface.dart';


class ContentSearchField extends StatelessWidget {
  final String? hintText;
  final SearchFieldViewModelInterface? viewModel;

  const ContentSearchField({
    Key? key,
    this.hintText,
    this.viewModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextField(
      decoration: InputDecoration(
        hintText: hintText!,
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {viewModel?.search("omg_test_3");},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}