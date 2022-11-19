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
                    decoration: InputDecoration(
                      hintText: 'Input Name',
                      label: Text('Name'),
                      labelStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  TextField(
                    controller: controller.genderC,
                    decoration: InputDecoration(
                      hintText: 'Input Gender',
                      label: Text('Gender'),
                      labelStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  TextField(
                    controller: controller.addressC,
                    decoration: InputDecoration(
                      hintText: 'Input Address',
                      label: Text('Address'),
                      labelStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  TextField(
                    controller: controller.hpC,
                    decoration: InputDecoration(
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
