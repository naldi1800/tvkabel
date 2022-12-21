import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';

import '../controllers/edit_customer_controller.dart';

class EditCustomerView extends GetView<EditCustomerController> {
  const EditCustomerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sunting Pelanggan'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: StreamBuilder<DocumentSnapshot<Object?>>(
                stream: controller.getData(Get.arguments),
                builder: (c, snapshot) {
                  controller.getPakets();
                  if (snapshot.connectionState == ConnectionState.active &&
                      controller.paketForSelect.value != null) {
                    List<Map<String, dynamic>> item = [];
                    var data = snapshot.data!.data() as Map<String, dynamic>;
                    controller.nameC.text = data['name'] ?? '';
                    controller.setGender("${data['gender']}".obs);
                    controller.hpC.text = data['hp'] ?? '';
                    controller.addressC.text = data['address'] ?? '';
                    controller.workC.text = data['work'] ?? '';
                    DateTime d = DateTime.now();
                    if (data['date'] != null) {
                      Timestamp t = data['date'];
                      d = t.toDate();
                    }
                    controller.dateC.text = data['date'] != null
                        ? DateFormat('yyyy-MM-dd').format(d)
                        : '';
                    controller.paketForSelect.value.forEach((element) {
                      print(element);
                      item.add(element);
                      if (element['id'] == data['iuran']) {
                        controller.iuranC.text = element['label'];
                      }
                    });

                    return Obx(() => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Edit Pelanggan",
                                style: TextStyle(fontSize: 25)),
                            SizedBox(height: 15),
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
                            Row(
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
                            //   decoration: InputDecoration(
                            //     hintText: 'Input Iuran',
                            //     label: Text('Iuran'),
                            //     labelStyle: TextStyle(fontSize: 15),
                            //   ),
                            // ),
                            // SelectFormField(
                            //   controller: controller.iuranC,
                            //   labelText: "Iuran",
                            //   items: item,
                            // ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: controller.dateC,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.calendar_today),
                                labelText: "Tanggal Pemasangan",
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now());

                                if (pickedDate != null) {
                                  print(pickedDate);
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(formattedDate);
                                  controller.dateC.text = formattedDate;
                                } else {
                                  print("Date is not selected");
                                }
                              },
                            ),
                            const SizedBox(height: 10),

                            ElevatedButton(
                              child: const Text("Save"),
                              onPressed: () => controller.edit(
                                controller.nameC.text,
                                controller.genders.value,
                                controller.addressC.text,
                                controller.hpC.text,
                                controller.workC.text,
                                controller.iuranC.text,
                                controller.dateC.text,
                                Get.arguments,
                              ),
                            ),
                          ],
                        ));
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ),
        ),
      ),
    );
  }
}
