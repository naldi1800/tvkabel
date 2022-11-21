import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tvkabel/app/routes/app_pages.dart';

import '../controllers/detail_customer_controller.dart';

class DetailCustomerView extends GetView<DetailCustomerController> {
  const DetailCustomerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pelanggan'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Get.toNamed(
              Routes.EDIT_CUSTOMER,
              arguments: Get.arguments,
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => controller.delete(Get.arguments),
          ),
        ],
      ),
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(3),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: FutureBuilder<DocumentSnapshot<Object?>>(
                  future: controller.getData(Get.arguments),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var data = snapshot.data!.data() as Map<String, dynamic>;
                      print(data);
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${data['name']}",
                                style: TextStyle(fontSize: 30),
                              ),
                              Text(
                                "${data['iuran']}",
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                "Alamat : ${data['address']}",
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Jenis Kelamin : ${data['gender']}",
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "No Telp/HP : ${data['hp']}",
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Pekerjaan : ${data['work']}",
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {},
                child: Text("Riwayat Pembayaran"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
