import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddCustomerController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController addressC;
  late TextEditingController emailC;
  late TextEditingController hpC;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void add(String name, String address, String email, String hp) async {
    CollectionReference costumers = firestore.collection("costumers");

    try {
      await costumers.add({
        "name": name,
        "address": address,
        "email": email,
        "hp": hp,
      });

      Get.defaultDialog(
        title: "Success",
        middleText: "Success for adding Costumer",
        onConfirm: () => Get.back(),
        textConfirm: "Ok",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Failed",
        middleText: "Failed for adding Costumer!!",
        onConfirm: () => Get.back(),
        textConfirm: "Ok",
      );
    }
  }

  @override
  void onInit() {
    nameC = TextEditingController();
    addressC = TextEditingController();
    emailC = TextEditingController();
    hpC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameC.dispose();
    addressC.dispose();
    emailC.dispose();
    hpC.dispose();
    super.onClose();
  }
}
