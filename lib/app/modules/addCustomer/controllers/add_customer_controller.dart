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

  var genders = "Laki-laki".obs;
  List<Map<String, dynamic>> item = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void setGender(RxString v) {
    genderC.text = v.value;
    genders.value = v.value;
  }

  Stream<QuerySnapshot<Object?>> getPakets() {
    Query value = firestore.collection('packets').orderBy('price');
    return value.snapshots();
  }

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
        onConfirm: () {
          nameC.clear();
          genderC.clear();
          addressC.clear();
          hpC.clear();
          workC.clear();
          iuranC.clear();
          Get.back();
          Get.back();
        },
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
    genderC = TextEditingController(text: "Laki-laki");
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
