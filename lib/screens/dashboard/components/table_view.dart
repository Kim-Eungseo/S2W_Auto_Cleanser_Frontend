import 'dart:convert';
import 'dart:html' as html;
import 'package:admin/models/RecentFile.dart';
import 'package:admin/viewmodels/interfaces/table_viewmodel_interface.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../responsive.dart';
import 'flow_button.dart';

class TableView extends StatefulWidget {
  final String? title;
  final TableViewModelInterface? viewModel;
  final void Function(Map<String, dynamic> map)? onRowTap;
  final bool? isButton;
  final IconData? buttonIcon;
  final String? buttonText;
  final void Function()? onButtonTap;
  final bool? isDownload;


  const TableView({
    Key? key,
    this.title,
    this.viewModel,
    this.onRowTap,
    this.isButton,
    this.buttonIcon,
    this.buttonText,
    this.onButtonTap,
    this.isDownload
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TableView();
}

class _TableView extends State<TableView> {
  String? title;
  TableViewModelInterface? viewModel;
  void Function(Map<String, dynamic> map)? onRowTap;
  bool? isButton;
  IconData? buttonIcon;
  String? buttonText;
  void Function()? onButtonTap;
  bool? isDownload;

  final ScrollController _scrollController = ScrollController();


  void initState() {
    this.title = widget.title;
    this.viewModel = widget.viewModel;
    this.onRowTap = widget.onRowTap;
    this.isButton = widget.isButton;
    this.buttonIcon = widget.buttonIcon;
    this.buttonText = widget.buttonText;
    this.onButtonTap = widget.onButtonTap;
    this.isDownload = widget.isDownload;
  }

  @override
  Widget build(BuildContext context) {
    List<String>? tableColumnList = viewModel?.tableColumnList;
    List<Map<String, dynamic>>? tableDataList = viewModel?.getTableDataList();

    double tableHeight = viewModel!.tableDataList.length * 60 >= 60 ? viewModel!.tableDataList.length * 60 + 100: 100;
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
                  title!,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                if (this.isButton ?? false)
                  ElevatedButton.icon(
                    style: TextButton.styleFrom(

                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                      ),
                    ),
                    onPressed: onButtonTap ?? () {},
                    icon: Icon(this.buttonIcon ?? Icons.add),
                    label: Text(this.buttonText ?? "Add New"),
                  ),
                if(this.isDownload ?? false)
                  ElevatedButton.icon(
                    style: TextButton.styleFrom(

                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                      ),
                    ),
                    onPressed: downloadCsvFile,
                    icon: Icon(this.buttonIcon ?? Icons.download_done_rounded),
                    label: Text(this.buttonText ?? "Download"),
                  ),
             ]
          ),
          Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller:_scrollController,
              primary: false,
              // child: SingleChildScrollView(
              //   scrollDirection: Axis.vertical,
              //   primary: false,
                child: SizedBox(
                  width: viewModel!.tableColumnList.length * 300.0,
                  height: tableHeight > 400.0 ? 400.0 : tableHeight,
                  child: DataTable2(
                    dataRowHeight: 60,
                    columnSpacing: defaultPadding,
                    minWidth: viewModel!.tableColumnList.length * 300.0,
                    columns: [
                      for (String s in tableColumnList!)
                        DataColumn(
                          label: Text(
                              s,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                    ],
                    // rows: List.generate(
                    //   demoRecentFiles.length,
                    //   (index) => recentFileDataRow(demoRecentFiles[index]),
                    // ),
                    rows: List.generate(
                      tableDataList!.length,
                          (index) => returnTableData(tableDataList[index], tableColumnList),
                    ),
                  ),
                ),
              // ),
            ),
          ),
        ],
      ),
    );
  }

  // 이 부분 파라미터 개수를 줄일 수 있는 방법을 모색해야 한다.
  DataRow returnTableData(Map<String, dynamic> map, List<String> colList) {
    return DataRow(
      cells: [
        for (String col in colList)
          DataCell(
              Text(
                  map[col].toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5
              ),
            onTap: () => (onRowTap ?? (Map<String, dynamic> map) {})(map)
          )
      ],
    );
  }

  void downloadCsvFile() {

    final text = makeCsvString();

    // prepare
    final bytes = utf8.encode(text);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'data.csv';
    html.document.body?.children.add(anchor);

    // download
    anchor.click();

    // cleanup
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  String makeCsvString() {
    String data = "";
    var colList = viewModel?.tableColumnList;
    var dataList = viewModel?.tableDataList;

    data += colList!.join(",");
    data += "\n";

    for (Map<String, dynamic> d in dataList!) {
      for (String col in colList) {
        var tempList = [];
        tempList.add(d[col] as String);
        data += tempList.join(',');
      }
      data += "\n";
    }
    return data;
  }
}


