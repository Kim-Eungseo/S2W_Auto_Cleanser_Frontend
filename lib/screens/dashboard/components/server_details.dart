import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'server_info_card.dart';

class ServerDetails extends StatelessWidget {

  const ServerDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: tertiaryColor.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Server Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),

          // ServerInfoCard(
          //   svgSrc: "assets/icons/Documents.svg",
          //   title: "Documents Files",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 1328,
          // ),
          // ServerInfoCard(
          //   svgSrc: "assets/icons/media.svg",
          //   title: "Media Files",
          //   amountOfFiles: "15.3GB",
          //   numOfFiles: 1328,
          // ),
          // ServerInfoCard(
          //   svgSrc: "assets/icons/folder.svg",
          //   title: "Other Files",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 1328,
          // ),
          // ServerInfoCard(
          //   svgSrc: "assets/icons/unknown.svg",
          //   title: "Unknown",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 140,
          // ),
        ],
      ),
    );
  }
}
