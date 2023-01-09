import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:tvkabel/app/utils/ui.dart';

import '../controllers/add_customer_controller.dart';

class AddCustomerView extends GetView<AddCustomerController> {
  AddCustomerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Pelanggan',
          style: TextStyle(
            fontFamily: 'arvo',
            color: ui.object,
          ),
        ),
        centerTitle: true,
        backgroundColor: ui.foreground,
      ),
      backgroundColor: ui.background,
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
                // print(item);

                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Pelanggan",
                              style: TextStyle(fontSize: 25, color: ui.object)),
                          const SizedBox(height: 15),
                          TextField(
                            controller: controller.nameC,
                            decoration: const InputDecoration(
                              hintText: 'Input Name',
                              label: Text('Name'),
                              labelStyle:
                                  TextStyle(fontSize: 15, color: ui.action),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Gender",
                              style: TextStyle(fontSize: 15, color: ui.action),
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
                                    style: TextStyle(
                                        fontSize: 12, color: ui.object),
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
                                    style: TextStyle(
                                        fontSize: 12, color: ui.object),
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
                              labelStyle:
                                  TextStyle(fontSize: 15, color: ui.action),
                            ),
                          ),
                          TextField(
                            controller: controller.hpC,
                            decoration: const InputDecoration(
                              hintText: 'Input Telp',
                              label: Text('Telp'),
                              labelStyle:
                                  TextStyle(fontSize: 15, color: ui.action),
                            ),
                          ),
                          TextField(
                            controller: controller.workC,
                            decoration: const InputDecoration(
                              hintText: 'Input Work',
                              label: Text('Work'),
                              labelStyle:
                                  TextStyle(fontSize: 15, color: ui.action),
                            ),
                          ),
                          SelectFormField(
                            controller: controller.iuranC,
                            style: TextStyle(color: ui.action),
                            labelText: "Iuran",
                            items: item,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: controller.dateC,
                            style: TextStyle(color: ui.action),
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.calendar_today,
                                color: ui.action,
                              ),
                              labelText: "Tanggal Pemasangan",
                              labelStyle: TextStyle(color: ui.object),
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
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(formattedDate);
                                controller.dateC.text = formattedDate;
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(ui.action)),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: ui.object, fontFamily: 'arvo'),
                            ),
                            // onPressed: () => controller.tes(),
                            onPressed: () => controller.add(
                              controller.nameC.text,
                              controller.genders.value,
                              controller.addressC.text,
                              controller.hpC.text,
                              controller.workC.text,
                              controller.iuranC.text,
                              controller.dateC.text,
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
