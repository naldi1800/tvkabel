import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tvkabel/app/routes/app_pages.dart';
import 'package:tvkabel/app/utils/ui.dart';

import '../controllers/detail_customer_controller.dart';

class DetailCustomerView extends GetView<DetailCustomerController> {
  const DetailCustomerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Pelanggan',
          style: TextStyle(
            fontFamily: 'arvo',
            color: ui.object,
          ),
        ),
        backgroundColor: ui.foreground,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            color: ui.action,
            onPressed: () => Get.toNamed(
              Routes.EDIT_CUSTOMER,
              arguments: Get.arguments,
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: ui.action,
            onPressed: () => controller.delete(Get.arguments),
          ),
        ],
      ),
      backgroundColor: ui.background,
      body: StreamBuilder<DocumentSnapshot<Object?>>(
        stream: controller.getData(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.data() == null) {
              print("Kosong cok");
              return const Center(child: CircularProgressIndicator());
            }
            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.getPaket(data['iuran']);
            DateTime d = DateTime.now();
            if (data['date'] != null) {
              Timestamp t = data['date'];
              d = t.toDate();
            }
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
                            color: ui.foreground,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${data['name']}",
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontFamily: 'arvo',
                                        color: ui.object),
                                  ),
                                  Text(
                                    "Paket ${controller.paket.value['name']} - ${controller.paket.value['price']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'arvo',
                                        color: ui.object),
                                  ),
                                  const SizedBox(height: 15),
                                  viewDataCustomer(
                                    context: context,
                                    ket: "Alamat",
                                    data: data['address'] ?? '-',
                                  ),
                                  viewDataCustomer(
                                    context: context,
                                    ket: "Jenis Kelamin",
                                    data: data['gender'] ?? '-',
                                  ),
                                  viewDataCustomer(
                                    context: context,
                                    ket: "No Telp",
                                    data: data['hp'] ?? '-',
                                  ),
                                  viewDataCustomer(
                                    context: context,
                                    ket: "Pekerjaan",
                                    data: data['work'] ?? '-',
                                  ),
                                  viewDataCustomer(
                                    context: context,
                                    ket: "Tanggal Pemasangan",
                                    data: data['date'] != null
                                        ? DateFormat('yyyy-MM-dd').format(d)
                                        : '-',
                                  ),
                                  const SizedBox(height: 15),
                                  // ElevatedButton(
                                  //   onPressed: () {},

                                  //   child: const Text("Riwayat Pembayaran", style: TextStyle(fontFamily: 'arvo', color: ui.object),),
                                  // ),
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
          return const Center(child: CircularProgressIndicator());
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
            style: TextStyle(
                fontSize: sizeFont, fontFamily: 'arvo', color: ui.object),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          width: widthMax * 0.03,
          child: Text(
            ":",
            style: TextStyle(
                fontSize: sizeFont, fontFamily: 'arvo', color: ui.object),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: widthMax * 0.5,
          child: Text(
            " $data",
            style: TextStyle(
                fontSize: sizeFont, fontFamily: 'arvo', color: ui.object),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
