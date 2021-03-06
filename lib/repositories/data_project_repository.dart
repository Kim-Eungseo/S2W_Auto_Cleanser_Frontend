import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';


class DataProjectRepository {
  late final RemoteDataSource4DataProject remoteDataSource;

  DataProjectRepository() {
    remoteDataSource = RemoteDataSource4DataProject();
  }
}

class RemoteDataSource4DataProject {
  Future<List<DataProjectDto>> getDataProjectByName(String name) async {
    String uri = apiServerUri + "/project/?name=" + name;
    final res = await http.get(Uri.parse(uri));
    if (res.statusCode == 200) {
      final data = json.decode(res.body) as List;
      return data.map((ele) => DataProjectDto.fromJson(ele as Map<String, dynamic>)).toList();
    } else {
      throw Exception("Error on server");
    }
  }

  Future<DataProjectDto> getDataProjectById(String id) async {
    String uri = apiServerUri + "/project/get/" + id;
    final res = await http.get(Uri.parse(uri));
    if (res.statusCode == 200) {
      final data = DataProjectDto.fromJson(json.decode(res.body)) ;
      return data;
    } else {
      throw Exception("Error on server");
    }
  }

  Future<bool> deleteDataProjectById(String id) async {
    String uri = apiServerUri + "/project/delete?id_=" + id.toString();
    final res = await http.delete(Uri.parse(uri));
    if (res.statusCode == 200) {
      if (res.body == 'true'){
        print("Yeaaaaaaaaaah");
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception("Error on server");
    }
  }

  Future<DataProjectDto> updateDataProjectByMap(Map<String, dynamic> map) async {
    String uri = apiServerUri + "/project/update";
    final res = await http.post(
      Uri.parse(uri),
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
      body: map as Map<String, String>
    );
    if (res.statusCode == 200) {
      final data = DataProjectDto.fromJson(json.decode(res.body)) ;
      return data;
    } else {
      throw Exception("Error on server");
    }
  }

  Future<DataProjectDto> newDataProjectByMap(Map<String, dynamic> map) async {
    print(map.toString());
    String uri = apiServerUri + "/project/new";
    final res = await http.post(
        Uri.parse(uri),
        headers: <String, String> {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(map as Map<String, String>)
    );
    if (res.statusCode == 200) {
      final data = DataProjectDto.fromJson(json.decode(res.body)) ;
      return data;
    } else {
      throw Exception("Error on server");
    }
  }
}