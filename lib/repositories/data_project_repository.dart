import 'package:admin/viewmodels/data_project_viewmodel.dart';

class DataProjectRepository {
  late final RemoteDataSource remoteDataSource;
}

class RemoteDataSource {
  Future<List<DataProjectDto>> getDataProjectByName(String name) async {
    const path = '/v1/project';
    const params = <String, String>{"name": name};
    const uri = Uri.https("localhost:8000", path, params);
    final res = await http.get(uri);
    if (res.statusCode == HttpStatus.ok) {
      final data = _bytesToJson(res.bodyBytes) as List;
      return data.map((el) => Post.fromMap(el as Map)).toList();
    } else {
      throw Exception("Error on server");
    }
  }
}