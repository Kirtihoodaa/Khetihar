import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';

class ReportAnalysis extends StatelessWidget {
  const ReportAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KCenteredActionsAppBar(title: "Report Analysis"),
      backgroundColor: Colors.white,
      body: ListView(children: []),
    );
  }
}
