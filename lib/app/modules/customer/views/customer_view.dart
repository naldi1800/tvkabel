import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tvkabel/app/routes/app_pages.dart';
import 'package:tvkabel/app/utils/ui.dart';

import '../controllers/customer_controller.dart';

class CustomerView extends GetView<CustomerController> {
  const CustomerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Pelanggan',
          style: TextStyle(fontFamily: 'alvo', color: ui.object),
        ),
        centerTitle: true,
        backgroundColor: ui.foreground,
      ),
      backgroundColor: ui.background,
      body: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
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
                        itemCount: controller.allData.value.length,
                        separatorBuilder: (context, index) {
                          return const Divider(color: ui.action);
                        },
                        itemBuilder: (context, index) {
                          var data = controller.allData.value[index].data()
                              as Map<String, dynamic>;
                          return on(
                            controller.allData.value[index].id,
                            index,
                            data,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ui.action,
        child: Icon(
          Icons.add,
          color: ui.object,
        ),
        onPressed: () => Get.toNamed(Routes.ADD_CUSTOMER),
      ),
    );
  }

  Widget on(var id, int index, var data) {
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
            Routes.DETAIL_CUSTOMER,
            arguments: id,
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
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: ui.action,
                ),
                onPressed: () => Get.toNamed(
                  Routes.EDIT_CUSTOMER,
                  arguments: id,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
