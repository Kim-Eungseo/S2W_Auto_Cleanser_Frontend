import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ServerDetailsViewModel extends ChangeNotifier {

  Timer? timer;
  double? usedRam;
  double? totalRam;
  double? usedDisk;
  double? totalDisk;
  double? cpuUsage;

  ServerDetailsViewModel() {
    this.timer = Timer.periodic(Duration(seconds: 3), (Timer t) => checkForRamUsage());
  }

  void checkForRamUsage() async{
    // do request here
    print("ram listen");
    Future<Map<String, String>> data = getServerMetrics();

    await data.then((unfuturedData) {
      this.usedRam = (double.parse(unfuturedData['percent']!)
          * int.parse(unfuturedData['total']!) / 1024 / 1024 / 1024 / 100);
      this.totalRam = (int.parse(unfuturedData['total']!) / 1024 / 1024 / 1024);
      this.usedDisk = (double.parse(unfuturedData['disk_used']!)/ 1024 / 1024 / 1024);
      this.totalDisk = (int.parse(unfuturedData['disk_total']!) / 1024 / 1024 / 1024);
      this.cpuUsage = double.parse(unfuturedData['cpu_percent']!);
    });
    notifyListeners();
  }

  Future<Map<String, String>> getServerMetrics() async {
    String uri = "http://10.0.40.140/v2/process/metrics";
    final res = await http.get(Uri.parse(uri));
    if (res.statusCode == 200) {
      var data = Map<String, String>.from(json.decode(res.body));
      return data;
    } else {
      throw Exception("Error on server");
    }
  }
}



