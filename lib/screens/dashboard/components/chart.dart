import 'dart:async';
import 'dart:convert';
import 'package:admin/viewmodels/server_details_viewmodel.dart';
import 'package:http/http.dart' as http;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

// class Chart extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _Chart();
//
// }
//
// class _Chart extends State<Chart> {
class Chart extends StatelessWidget {
  // Timer? timer;

  double? usedRam;
  double? totalRam;
  double? usedDisk;
  double? totalDisk;
  double? cpuUsage;


  @override
  Widget build(BuildContext context) {
    this.usedRam = context.watch<ServerDetailsViewModel>().usedRam;
    this.totalDisk = context.watch<ServerDetailsViewModel>().totalDisk;
    this.totalRam = context.watch<ServerDetailsViewModel>().totalRam;
    this.usedDisk = context.watch<ServerDetailsViewModel>().usedDisk;
    this.cpuUsage = context.watch<ServerDetailsViewModel>().cpuUsage;


    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 70,
                  startDegreeOffset: -90,
                  sections: pieChartSelectionDatasRam(),
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("RAM"),
                    SizedBox(height: defaultPadding),
                    Text(
                      (usedRam ?? 0.0).toStringAsFixed(1),
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            height: 0.5,
                          ),
                    ),
                    Text("of " + (totalRam ?? 0.0).toStringAsFixed(1) + "GB")
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: defaultPadding,),
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 70,
                  startDegreeOffset: -90,
                  sections: pieChartSelectionDatasDisk(),
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Disk"),
                    SizedBox(height: defaultPadding),
                    Text(
                      (usedDisk ?? 0.0).toStringAsFixed(1),
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                    ),
                    Text("of " + (totalDisk ?? 0.0).toStringAsFixed(1) + "GB")
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: defaultPadding,),
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 70,
                  startDegreeOffset: -90,
                  sections: pieChartSelectionDatasCpu(),
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("CPU"),
                    SizedBox(height: defaultPadding),
                    Text(
                      (cpuUsage ?? 0.0).toStringAsFixed(1) + "%",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                    ),
                    // Text("of total CPU resource")
                  ],
                ),
              ),
            ],
          ),
        ),
      ]
    );
  }

  List<PieChartSectionData> pieChartSelectionDatasRam(){
    return [
      PieChartSectionData(
        color: Color(0xFFEE2727),
        value: (usedRam ?? 0).toDouble(),
        showTitle: false,
        radius: 25,
      ),
      PieChartSectionData(
        color: primaryColor.withOpacity(0.1),
        value: ((totalRam ?? 25) - (usedRam ?? 0)).toDouble(),
        showTitle: false,
        radius: 13,
      ),
    ];
  }

  List<PieChartSectionData> pieChartSelectionDatasDisk(){
    return [
      PieChartSectionData(
        color: Color(0xFFFFCF26),
        value: (usedDisk ?? 0).toDouble(),
        showTitle: false,
        radius: 25,
      ),
      PieChartSectionData(
        color: primaryColor.withOpacity(0.1),
        value: ((totalDisk ?? 25) - (usedDisk ?? 0)).toDouble(),
        showTitle: false,
        radius: 13,
      ),
    ];
  }

  List<PieChartSectionData> pieChartSelectionDatasCpu(){
    return [
      PieChartSectionData(
        color: primaryColor,
        value: (cpuUsage ?? 0).toDouble(),
        showTitle: false,
        radius: 25,
      ),
      PieChartSectionData(
        color: primaryColor.withOpacity(0.1),
        value: 100.0 - (cpuUsage ?? 0.0),
        showTitle: false,
        radius: 13,
      ),
    ];
  }

  Future<Map<String, String>> getServerMetrics() async {
    String uri = "http://localhost:8000/v1/process/metrics";
    final res = await http.get(Uri.parse(uri));
    if (res.statusCode == 200) {
      var data = Map<String, String>.from(json.decode(res.body));
      return data;
    } else {
      throw Exception("Error on server");
    }
  }
}


// PieChartSectionData(
//   color: Color(0xFF26E5FF),
//   value: 20,
//   showTitle: false,
//   radius: 22,
// ),
// PieChartSectionData(
//   color: Color(0xFFFFCF26),
//   value: 10,
//   showTitle: false,
//   radius: 19,
// ),
// PieChartSectionData(
//   color: Color(0xFFEE2727),
//   value: 15,
//   showTitle: false,
//   radius: 16,
// ),