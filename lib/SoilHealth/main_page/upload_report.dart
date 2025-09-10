import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/SoilHealth/main_page/report_analysis.dart';

import '../internal_ui&components/or_photo&formats.dart';
import '../internal_ui&components/soil_info_actions.dart';
import '../internal_ui&components/upload_report_card.dart';

class UploadReport extends StatelessWidget {
  const UploadReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KCenteredActionsAppBar(title: "Upload Report"),
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: UploadSoilTestCard(
                onBrowse: () {
                  // TODO: open file picker
                },
                onTapDropzone: () {
                  // TODO: also open file picker
                },
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: OrPhotoAndFormats(
                onTakePhoto: () {
                  // TODO: open camera / image picker
                },
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: SoilInfoAndActionsPerfect(
                onCancel: () {
                  Get.back();
                },
                onUpload: () {
                  Get.to(() => ReportAnalysis());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
