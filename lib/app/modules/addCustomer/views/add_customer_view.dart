import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:select_form_field/select_form_field.dart';

import '../controllers/add_customer_controller.dart';

class AddCustomerView extends GetView<AddCustomerController> {
  AddCustomerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pelanggan'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: controller.getPakets(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                var data = snapshot.data!.docs;
                List<Map<String, dynamic>> item = [];
                data.forEach((element) {
                  var x = element.data() as Map<String, dynamic>;
                  item.add({
                    'value': element.id,
                    'label': "${x['name']} - ${x['price']}",
                  });
                });
                print(item);

                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Pelanggan",
                              style: TextStyle(fontSize: 25)),
                          const SizedBox(height: 15),
                          TextField(
                            controller: controller.nameC,
                            decoration: const InputDecoration(
                              hintText: 'Input Name',
                              label: Text('Name'),
                              labelStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Gender",
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Obx(
                            () => Row(
                              children: [
                                Radio(
                                  value: "Laki-laki",
                                  groupValue: controller.genders.value,
                                  onChanged: (e) {
                                    var v = "Laki-laki".obs;
                                    controller.setGender(v);
                                  },
                                ),
                                GestureDetector(
                                  onTap: () {
                                    var v = "Laki-laki".obs;
                                    controller.setGender(v);
                                  },
                                  child: const Text(
                                    'Laki-laki',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                Radio(
                                  value: "Perempuan",
                                  groupValue: controller.genders.value,
                                  onChanged: (e) {
                                    var v = "Perempuan".obs;
                                    controller.setGender(v);
                                  },
                                ),
                                GestureDetector(
                                  onTap: () {
                                    var v = "Perempuan".obs;
                                    controller.setGender(v);
                                  },
                                  child: const Text(
                                    'Perempuan',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextField(
                            controller: controller.addressC,
                            decoration: const InputDecoration(
                              hintText: 'Input Address',
                              label: Text('Address'),
                              labelStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                          TextField(
                            controller: controller.hpC,
                            decoration: const InputDecoration(
                              hintText: 'Input Telp',
                              label: Text('Telp'),
                              labelStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                          TextField(
                            controller: controller.workC,
                            decoration: const InputDecoration(
                              hintText: 'Input Work',
                              label: Text('Work'),
                              labelStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                          // TextField(
                          //   controller: controller.iuranC,
                          //   decoration: const InputDecoration(
                          //     hintText: 'Input Iuran',
                          //     label: Text('Iuran'),
                          //     labelStyle: TextStyle(fontSize: 15),
                          //   ),
                          // ),
                          SelectFormField(
                            controller: controller.iuranC,
                            labelText: "Iuran",
                            items: item,
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            child: Text("Save"),
                            onPressed: () => controller.add(
                              controller.nameC.text,
                              controller.genders.value,
                              controller.addressC.text,
                              controller.hpC.text,
                              controller.workC.text,
                              controller.iuranC.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

// var _package = snapshot.data!.docs;
// var paket = [];
// Future<List<Object?>> _paket = controller.getPrice(_package);
// _paket.then(
//   (value) {
//     if (value != null) {
//       value.forEach((element) => paket.add(value));
//     }
//   },
// );
// print(paket);
