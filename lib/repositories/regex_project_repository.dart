import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../viewmodels/regex_project_viewmodel.dart';


class RegexProjectRepository {
  late final RemoteDataSource4DataProject remoteDataSource;

  DataProjectRepository() {
    remoteDataSource = RemoteDataSource4DataProject();
  }
}

class RemoteDataSource4DataProject {
  Future<List<RegexProjectDto>> getRegexProjectByName(String name) async {
    String uri = "http://localhost:8000/v1/regex/?name=" + name;
    final res = await http.get(Uri.parse(uri));
    if (res.statusCode == 200) {
      final data = json.decode(res.body) as List;
      return data.map((ele) => RegexProjectDto.fromJson(ele as Map<String, dynamic>)).toList();
    } else {
      throw Exception("Error on server");
    }
  }

  Future<RegexProjectDto> getRegexProjectById(int id) async {
    String uri = "http://localhost:8000/v1/regex/" + id.toString();
    final res = await http.get(Uri.parse(uri));
    if (res.statusCode == 200) {
      final data = RegexProjectDto.fromJson(json.decode(res.body)) ;
      return data;
    } else {
      throw Exception("Error on server");
    }
  }
}