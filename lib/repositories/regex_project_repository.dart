
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:io' show Platform;
import '../constants.dart';
import '../viewmodels/regex_project_viewmodel.dart';


class RegexProjectRepository {
  late final RemoteDataSource4RegexProject remoteDataSource;

  RegexProjectRepository() {
    remoteDataSource = RemoteDataSource4RegexProject();
  }
}

class RemoteDataSource4RegexProject {


  Future<RegexProjectDto> newRegexProjectByMap(Map<String, String> map) async {
    print(map.toString());
    String uri = apiServerUri + "/regex/new";
    final res = await http.post(
        Uri.parse(uri),
        headers: <String, String> {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(map)
    );
    if (res.statusCode == 200) {
      final data = RegexProjectDto.fromJson(json.decode(res.body)) ;
      return data;
    } else {
      throw Exception("Error on server");
    }
  }

  Future<List<RegexProjectDto>> getRegexProjectByName(String name) async {
    String uri = apiServerUri + "/regex/?name=" + name;
    final res = await http.get(Uri.parse(uri));
    if (res.statusCode == 200) {
      final data = json.decode(res.body) as List;
      return data.map((ele) => RegexProjectDto.fromJson(ele as Map<String, dynamic>)).toList();
    } else {
      throw Exception("Error on server");
    }
  }

  Future<RegexProjectDto> getRegexProjectById(String id) async {
    String uri = apiServerUri + "/regex/" + id.toString();
    final res = await http.get(Uri.parse(uri));
    if (res.statusCode == 200) {
      final data = RegexProjectDto.fromJson(json.decode(res.body)) ;
      return data;
    } else {
      throw Exception("Error on server");
    }
  }

  Future<bool> deleteRegexProjectById(String id) async {
    String uri = apiServerUri + "/regex/delete?id_=" + id.toString();
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

  Future<RegexProjectDto> updateRegexProjectByMap(Map<String, dynamic> map) async {
    String uri = apiServerUri + "/regex/update";
    print(json.encode(map));
    final res = await http.post(
        Uri.parse(uri),
        headers: <String, String> {
          'Content-Type': 'application/json',
        },
        body: json.encode(map.map((key, value) => MapEntry(key, value?.toString())))
    );
    if (res.statusCode == 200) {
      final data = RegexProjectDto.fromJson(json.decode(res.body)) ;
      return data;
    } else {
      throw Exception("Error on server");
    }
  }
}