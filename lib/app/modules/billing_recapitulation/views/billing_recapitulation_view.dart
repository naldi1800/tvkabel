import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:tvkabel/app/utils/ui.dart';

import '../controllers/billing_recapitulation_controller.dart';

class BillingRecapitulationView
    extends GetView<BillingRecapitulationController> {
  const BillingRecapitulationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cek =
        "${Get.arguments.split("-")[0]}-${int.parse(Get.arguments.split("-")[1])}";
    print("cek $cek");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recapitulation',
          style: TextStyle(fontFamily: 'arvo', color: ui.object),
        ),
        centerTitle: true,
        backgroundColor: ui.foreground,
      ),
      backgroundColor: ui.background,
      body: FutureBuilder(
        future: controller.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // print(snapshot.data!.docs as List<Map<String, dynamic>>);
            return PdfPreview(
              build: (format) => controller.getPDF(context, snapshot.data!, cek),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
