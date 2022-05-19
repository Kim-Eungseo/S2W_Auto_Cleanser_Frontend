import 'dart:async';
import 'package:admin/viewmodels/selected_regex_table_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import 'document.dart';
import 'view.dart';
import 'input.dart';
import 'highlighter.dart';

class Editor extends StatefulWidget {
  Editor({Key? key,}) : super(key: key);
  @override
  _Editor createState() => _Editor();
}

class _Editor extends State<Editor> {
  late DocumentProvider doc;
  @override
  void initState() {
    doc = DocumentProvider(
        Document(Provider.of<SelectedRegexTableViewModel>(context, listen: false))
    );
    doc.openFile(Provider.of<SelectedRegexTableViewModel>(context, listen: false).code);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Python Code Editor",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Spacer()
                  ]
              ),
              SizedBox(height: defaultPadding),
              SizedBox(
                height: 400,
                child: MultiProvider(
                    providers: [
                      ChangeNotifierProvider(create: (context) => doc),
                      Provider(create: (context) => Highlighter())
                    ], child: InputListener(child: View())
                ),
              ),
          ]
        ),
    );
  }
}