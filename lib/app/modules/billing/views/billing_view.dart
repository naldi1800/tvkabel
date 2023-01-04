import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tvkabel/app/routes/app_pages.dart';

import '../controllers/billing_controller.dart';

class BillingView extends GetView<BillingController> {
  const BillingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penagihan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: StreamBuilder<QuerySnapshot<Object?>>(
          stream: controller.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var allDataCostumer = snapshot.data!.docs;
              return ListView.builder(
                itemCount: allDataCostumer.length,
                itemBuilder: (context, index) {
                  var data =
                      allDataCostumer[index].data() as Map<String, dynamic>;
                  return ListTile(
                    onTap: () => Get.toNamed(Routes.ADD_BILLING,
                        arguments: allDataCostumer[index].id),
                    title: Text(
                      "${data['name']}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      "${data['id']}",
                      style: const TextStyle(fontSize: 15),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
