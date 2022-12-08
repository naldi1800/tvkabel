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
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getData(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.getPaket(data['iuran']);
            // print(data);
            return Obx(
              () => Padding(
                padding: const EdgeInsets.all(3),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${data['name']}",
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                  Text(
                                    "Paket ${controller.paket.value['name']} - ${controller.paket.value['price']}",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(height: 15),
                                  viewDataCustomer(
                                    context: context,
                                    ket: "Alamat",
                                    data: data['address'],
                                  ),
                                  viewDataCustomer(
                                    context: context,
                                    ket: "Jenis Kelamin",
                                    data: data['gender'],
                                  ),
                                  viewDataCustomer(
                                    context: context,
                                    ket: "No Telp",
                                    data: data['hp'],
                                  ),
                                  viewDataCustomer(
                                    context: context,
                                    ket: "Pekerjaan",
                                    data: data['work'],
                                  ),
                                  SizedBox(height: 15),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("Riwayat Pembayaran"),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Row viewDataCustomer({
    required BuildContext context,
    required String ket,
    required String data,
  }) {
    double sizeFont = 15;
    double widthMax = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: widthMax * 0.3,
          child: Text(
            "$ket",
            style: TextStyle(fontSize: sizeFont),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          width: widthMax * 0.03,
          child: Text(
            ":",
            style: TextStyle(fontSize: sizeFont),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: widthMax * 0.5,
          child: Text(
            " $data",
            style: TextStyle(fontSize: sizeFont),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
