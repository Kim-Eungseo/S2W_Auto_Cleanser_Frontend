import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DataProjectView extends StatelessWidget {
  late DataProjectViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<DataProjectViewModel>(context); // Provider로 viewModel을 가져온다.
    return Scaffold(
      appBar: AppBar(title: Text('Post List')),
      body: _buildPostList(),
    );
  }

  Widget _buildPostList() {
    final items = viewModel.dataList;     // viewModel에 저장된 items
    final itemCount = items.length;
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(title: Text(item.name ?? "null"));
      },
      itemCount: itemCount,
    );
  }
}