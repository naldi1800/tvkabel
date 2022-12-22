import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HistoryView'),
        centerTitle: true,
      ),
      body: const Center(child: CircularProgressIndicator()),
      // body: Padding(padding: EdgeInsets.all(20),
      //   child: StreamBuilder<QuerySnapshot<Object?>>(
      //     stream: controller.getData(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.active) {
      //         var allDataCostumer = snapshot.data!.docs;
      //       }}),
      //         ,),
    );
  }
}
