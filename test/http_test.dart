import 'package:admin/repositories/data_project_repository.dart';
import 'package:admin/viewmodels/data_project_viewmodel.dart';
import 'package:test/test.dart';

void main() {
  test("getDataProjectByName", () async {
    // given
    RemoteDataSource4DataProject remoteDataSource = RemoteDataSource4DataProject();
    
    // when
    Future<List<DataProjectDto>> data = remoteDataSource
        .getDataProjectByName("omg_test_3");

    //then
    await data.then((value) {
      var len = value.length;
      print('List length is $len');
      for (DataProjectDto d in value) {
        print(d.toString());
      }
    }).whenComplete(() {
      print("All completed");
    });
    print("async testing");
  });

}
