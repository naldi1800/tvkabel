import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../controllers/billing_recapitulation_controller.dart';

class BillingRecapitulationView
    extends GetView<BillingRecapitulationController> {
  const BillingRecapitulationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recapitulation'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getDataWithMonth("2022-12"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // print(snapshot.data!.docs as List<Map<String, dynamic>>);
            return PdfPreview(
              build: (format) => controller.getPDF(context, snapshot.data!),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     controller.getPDF();
      //   },
      //   child: const Icon(Icons.picture_as_pdf),
      // ),
      // body: ,
      // body: Padding(
      //   padding: const EdgeInsets.all(20),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       const Text("Recapitulation"),
      //       ElevatedButton(
      //         child: const Text("Submit"),
      //         onPressed: () {},
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
