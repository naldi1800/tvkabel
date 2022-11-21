import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tvkabel/app/routes/app_pages.dart';

import '../controllers/customer_controller.dart';

class CustomerView extends GetView<CustomerController> {
  const CustomerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pelanggan'),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {
        //       controller.isSearch.value = !controller.isSearch.value;
        //     },
        //   )
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.all(5.0),
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
                    onTap: () => Get.toNamed(Routes.DETAIL_CUSTOMER,
                        arguments: allDataCostumer[index].id),
                    title: Text(
                      "${data['name']}",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      "${data['address']}",
                      style: TextStyle(fontSize: 15),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => Get.toNamed(Routes.EDIT_CUSTOMER,
                              arguments: allDataCostumer[index].id),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => controller.delete(
                              allDataCostumer[index].id, data['name']),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        // Stack(
        // mainAxisAlignment: MainAxisAlignment.start,
        // children: [
        // Visibility(
        //   visible: controller.isSearch.value,
        //   child: Container(
        //     padding: EdgeInsets.symmetric(horizontal: 20),
        //     child: TextField(
        //       controller: controller.searchC,
        //       decoration: InputDecoration(hintText: "Search..."),
        //     ),
        //   ),
        // ),

        // ],
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.toNamed(Routes.ADD_CUSTOMER),
      ),
    );
  }
}
