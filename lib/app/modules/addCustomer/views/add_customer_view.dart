import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_customer_controller.dart';

class AddCustomerView extends GetView<AddCustomerController> {
  const AddCustomerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pelanggan'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              // mainAxisAlignment: MainAxisAlignment.center,
              child: Column(
                children: [
                  Text("Pelanggan", style: TextStyle(fontSize: 25)),
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
                          child: Text(
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
                          child: Text(
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
                    decoration: InputDecoration(
                      hintText: 'Input Work',
                      label: Text('Work'),
                      labelStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  TextField(
                    controller: controller.iuranC,
                    decoration: InputDecoration(
                      hintText: 'Input Iuran',
                      label: Text('Iuran'),
                      labelStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: Text("Save"),
                    onPressed: () => controller.add(
                      controller.nameC.text,
                      controller.genderC.text,
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
        ),
      ),
    );
  }
}
