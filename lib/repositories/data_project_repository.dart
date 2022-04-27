import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataProjectRepository {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();

  /// 게시물 목록을 가져옴
  Future<List<DataProjectDto>> getDataProjects() {
    return _remoteDataSource.getDataProjects()();
  }
}

class RemoteDataSource {
  Future<List<DataProjectDto>> getDataProjects() async {
    const String uri = "http://localhost:8000/";
    final res = await http.get(uri);
    if (res.statusCode == HttpStatus.ok) {
      final data = _bytesToJson(res.bodyBytes) as List;
      return data.map((el) => DataProjectDto.fromMap(el as Map)).toList();
    } else {
      throw Exception("Error on server");
    }
  }
}