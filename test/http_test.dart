import 'package:admin/repositories/data_project_repository.dart';
import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:test/test.dart';

void main() {
  test("getDataProjectByName", () {
    // given
    RemoteDataSource remoteDataSource = RemoteDataSource();
    
    // when
    Future<List<DataProjectDto>> data = remoteDataSource
        .getDataProjectByName("omg_test_6");

    //then
    data.then((value) {
      print(value.length);
      print("hello world");
    });
    print("hello world");
  });
}
