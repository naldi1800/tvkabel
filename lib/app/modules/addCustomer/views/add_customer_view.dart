import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_customer_controller.dart';

class AddCustomerView extends GetView<AddCustomerController> {
  const AddCustomerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddCustomerView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddCustomerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
