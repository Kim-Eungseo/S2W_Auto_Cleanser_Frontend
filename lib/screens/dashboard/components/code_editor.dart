import 'package:admin/constants.dart';
import 'package:admin/screens/dashboard/components/code_editor/highlighter.dart';
import 'package:admin/viewmodels/interfaces/codable_viewmodel_interface.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
// Import the language & theme
import 'package:highlight/languages/python.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

class CodeEditor extends StatefulWidget {
  @override
  _CodeEditorState createState() => _CodeEditorState();
  CodableViewmodelInterface viewmodel;
  CodeEditor(this.viewmodel);
}

class _CodeEditorState extends State<CodeEditor> {
  CodeController? _codeController;
  CodableViewmodelInterface? viewmodel;
  @override
  void initState() {
    super.initState();
    this.viewmodel = widget.viewmodel;
    // Instantiate the CodeController

  }

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _codeController = CodeController(
        text: viewmodel!.code,
        language: python,
        theme: monokaiSublimeTheme,
        onChange: (code) {
          print(code);
          viewmodel!.code = code;
        }
    );
    return
      Container(
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
                    Spacer(),

                  ]
              ),
              SizedBox(height: defaultPadding),
              CodeField(
                controller: _codeController!,
                textStyle: TextStyle(fontFamily: 'SourceCode'),
                background: secondaryColor,
              )
            ]
        ),
      );
  }
}