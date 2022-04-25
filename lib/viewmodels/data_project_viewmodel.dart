import 'package:flutter/cupertino.dart';

class DataProjectViewModel with ChangeNotifier {


}

class DataProjectDto {
  String name;
  String author;
  String fileText;

  DataProjectDto(this.name, this.author, this.fileText);
}

