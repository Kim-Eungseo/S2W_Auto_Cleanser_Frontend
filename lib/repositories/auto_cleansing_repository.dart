import 'dart:collection';

import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';
import '../viewmodels/regex_project_viewmodel.dart';


class AutoCleansingRepository {
  late final RemoteDataSource4AutoCleansing remoteDataSource;

  AutoCleansingRepository() {
    remoteDataSource = RemoteDataSource4AutoCleansing();
  }
}

class RemoteDataSource4AutoCleansing {

  Future<Map<String, dynamic>> getAutoDetectionById(String id) async {
    String uri = apiServerUri + "/process/detect/?id_=" + id;
    final res = await http.get(Uri.parse(uri));
    if (res.statusCode == 200) {
      return json.decode(res.body) as Map<String, dynamic>;
    } else {
      throw Exception("Error on server");
    }
  }

  Future<Map<String, dynamic>> cleanseData(String req) async {
    String uri = apiServerUri + "/process/cleanse";
    print(req);
    final res = await http.post(
        Uri.parse(uri),
        headers: <String, String> {
          'Content-Type': 'application/json',
        },
        body: req
    );
    if (res.statusCode == 200) {
      return json.decode(res.body) as Map<String, dynamic>;
    } else {
      throw Exception("Error on server");
    }
  }
}