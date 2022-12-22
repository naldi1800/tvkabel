import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:select_form_field/select_form_field.dart';

import '../controllers/add_billing_controller.dart';

class AddBillingView extends GetView<AddBillingController> {
  const AddBillingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Pembayaran'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getData(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.getPaket(data['iuran']);
            controller.getPembayaran(data['date'], data['id']);
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
                                  textFieldBilling(
                                    context: context,
                                    ket: 'ID',
                                    value: data['id'] ?? '-',
                                  ),
                                  textFieldBilling(
                                    context: context,
                                    ket: 'Name',
                                    value: "${data['name']}",
                                  ),
                                  textFieldBilling(
                                    context: context,
                                    ket: 'Paket',
                                    value:
                                        "${controller.paket.value['name']} - ${controller.paket.value['price']}",
                                  ),
                                  Obx(
                                    () => SelectFormField(
                                      controller: controller.billingC,
                                      labelText: 'Pembayaran',
                                      autofocus: true,
                                      items: (controller.item.isNotEmpty)
                                          ? controller.item
                                              .map((e) =>
                                                  Map<String, dynamic>.from(e))
                                              .toList()
                                          : [
                                              {
                                                'value': "",
                                                'label':
                                                    'tidak ada yg perlu di bayar'
                                              }
                                            ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  const SizedBox(height: 15),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (controller.item.isEmpty ||
                                          controller.billingC.text != "") {
                                        Get.back();
                                      } else {
                                        controller.add(data['id'],
                                            controller.billingC.text);
                                      }
                                    },
                                    child: const Text("Bayar"),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                // ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  TextFormField textFieldBilling(
      {required BuildContext context,
      required String ket,
      required String value,
      TextEditingController? controller}) {
    return TextFormField(
      readOnly: true,
      controller: (controller != null)
          ? controller
          : TextEditingController(text: value),
      decoration: InputDecoration(
        // label: Text('Nama'),
        border: InputBorder.none,
        prefix: SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Row(
            children: [
              Expanded(
                child: Text(ket),
              ),
              Text(':  '),
            ],
          ),
        ),
      ),
    );
  }
}
