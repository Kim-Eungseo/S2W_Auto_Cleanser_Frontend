import 'dart:html';

import 'package:admin/models/RecentFile.dart';
import 'package:admin/viewmodels/interfaces/table_viewmodel_interface.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class TableView extends StatefulWidget {
  final String? title;
  final TableViewModelInterface? viewModel;
  final void Function(Map<String, dynamic> map)? onRowTap;
  final bool? isButton;
  final IconData? buttonIcon;
  final String? buttonText;
  final void Function()? onButtonTap;

  const TableView({
    Key? key,
    this.title,
    this.viewModel,
    this.onRowTap,
    this.isButton,
    this.buttonIcon,
    this.buttonText,
    this.onButtonTap,
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

  final ScrollController _scrollController = ScrollController();

  void initState() {
    this.title = widget.title;
    this.viewModel = widget.viewModel;
    this.onRowTap = widget.onRowTap;
    this.isButton = widget.isButton;
    this.buttonIcon = widget.buttonIcon;
    this.buttonText = widget.buttonText;
    this.onButtonTap = widget.onButtonTap;
  }

  @override
  Widget build(BuildContext context) {
    List<String>? tableColumnList = viewModel?.tableColumnList;
    List<Map<String, dynamic>>? tableDataList = viewModel?.getTableDataList();

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
             ]
          ),
          Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                primary: false,
                child: SizedBox(
                  width: viewModel!.tableColumnList.length * 300.0,
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
              ),
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
                  maxLines: 2
              ),
            onTap: () => (onRowTap ?? (Map<String, dynamic> map) {})(map)
          )
      ],
    );
  }

  DataRow recentFileDataRow(RecentFile fileInfo) {
    return DataRow(
      cells: [
        DataCell(Text(fileInfo.title!, overflow: TextOverflow.ellipsis, maxLines: 2,)),
        DataCell(Text(fileInfo.date!, overflow: TextOverflow.ellipsis, maxLines: 2,)),
        DataCell(Text(fileInfo.size!, overflow: TextOverflow.ellipsis, maxLines: 2,)),
        DataCell(Text("아 이거슨 타임스탬프여", overflow: TextOverflow.ellipsis,)),
      ],
    );
  }
}


