import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../viewmodels/interfaces/search_field_viewmodel_interface.dart';


class ContentSearchFieldView extends StatefulWidget {
  final String? hintText;
  final SearchFieldViewModelInterface? viewModel;

  const ContentSearchFieldView({
    Key? key,
    this.hintText,
    this.viewModel
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContentSearchField();

}

class _ContentSearchField extends State<ContentSearchFieldView> {
  String? hintText;
  SearchFieldViewModelInterface? viewModel;

  String fieldText = "";

  // const ContentSearchField({
  //   Key? key,
  //   this.hintText,
  //   this.viewModel
  // }) : super(key: key);

  @override
  void initState(){
    super.initState();
    this.hintText = widget.hintText;
    this.viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {

    return TextField(
      onChanged: (text) {
        fieldText = text;
      },
      decoration: InputDecoration(
        hintText: hintText!,
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {viewModel?.search(fieldText);},
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