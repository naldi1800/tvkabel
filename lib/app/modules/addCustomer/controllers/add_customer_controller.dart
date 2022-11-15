import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddCustomerController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController genderC;
  late TextEditingController addressC;
  late TextEditingController hpC;
  late TextEditingController workC;
  late TextEditingController iuranC;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void add(String name, String gender, String address, String hp, String work,
      String iuran) async {
    CollectionReference costumers = firestore.collection("costumers");

    try {
      await costumers.add({
        "name": name,
        "gender": gender,
        "address": address,
        "hp": hp,
        "work": work,
        "iuran": iuran,
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
    genderC = TextEditingController();
    addressC = TextEditingController();
    hpC = TextEditingController();
    workC = TextEditingController();
    iuranC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameC.dispose();
    genderC.dispose();
    addressC.dispose();
    hpC.dispose();
    workC.dispose();
    iuranC.dispose();
    super.onClose();
  }
}
