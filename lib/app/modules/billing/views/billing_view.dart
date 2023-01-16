import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tvkabel/app/routes/app_pages.dart';
import 'package:tvkabel/app/utils/ui.dart';

import '../controllers/billing_controller.dart';

class BillingView extends GetView<BillingController> {
  const BillingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Penagihan',
          style: TextStyle(fontFamily: 'alvo', color: ui.object),
        ),
        centerTitle: true,
        backgroundColor: ui.foreground,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.offAndToNamed(Routes.HOME),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.payment),
            onPressed: () {
              controller.billingFilter();
            },
          ),
        ],
      ),
      backgroundColor: ui.background,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: StreamBuilder<QuerySnapshot<Object?>>(
          stream: controller.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              controller.allDataCostumer = snapshot.data!.docs;
              controller.allData.value = controller.allDataCostumer;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller.searchC,
                      style:
                          const TextStyle(fontFamily: 'arto', color: ui.object),
                      onChanged: (value) {
                        controller.allData.value = controller.allDataCostumer;
                        controller.filter(value);
                      },
                      decoration: const InputDecoration(
                        labelText: "Search",
                        hintText: "id or name",
                        labelStyle: TextStyle(color: ui.object),
                        hintStyle: TextStyle(color: ui.object),
                        prefixIcon: Icon(
                          Icons.search,
                          color: ui.object,
                        ),
                        fillColor: ui.action,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => ListView.separated(
                        itemCount: controller.allData.length,
                        separatorBuilder: (context, index) {
                          return const Divider(color: ui.action);
                        },
                        itemBuilder: (context, index) {
                          var data = controller.allData[index].data()
                              as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Container(
                              width: double.infinity,
                              color: ui.foreground,
                              child: ListTile(
                                onTap: () => Get.toNamed(
                                  Routes.ADD_BILLING,
                                  arguments: controller.allData[index].id,
                                ),
                                title: Text(
                                  "${data['name']}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'alvo',
                                    color: ui.object,
                                  ),
                                ),
                                subtitle: Text(
                                  "${data['id']}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'alvo',
                                    color: ui.object,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
