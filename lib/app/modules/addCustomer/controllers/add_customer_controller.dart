import 'dart:async';

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
  late TextEditingController dateC;

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

  Future<String> getNewIDUser() async {
    Query getID = firestore
        .collection('costumers')
        .orderBy('id', descending: true)
        .limit(1);

    var idUser = "";
    await getID.get().then((QuerySnapshot event) {
      event.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        // print(data);
        idUser = data['id'];
        // print(idUser);
      });
    });
    return idUser;
  }

  void tes() async {
    // getNewIDUser();
    getNewIDUser().then((value) {
      var idPref = addZero(int.parse(value.split('-')[1]) + 1);
    });
  }

  String addZero(int number) {
    switch (number.toString().length) {
      case 1:
        return "00000$number";
      case 2:
        return "0000$number";
      case 3:
        return "000$number";
      case 4:
        return "00$number";
      case 5:
        return "0$number";
      case 6:
        return "$number";
    }
    return "$number";
  }

  void add(String name, String gender, String address, String hp, String work,
      String iuran, String date) async {
    CollectionReference costumers = firestore.collection("costumers");

    getNewIDUser().then((value) async {
      try {
        DateTime d = DateTime.parse(date);
        var idPref = addZero(int.parse(value.split('-')[1]) + 1);
        await costumers.add({
          "id": "TV-$idPref",
          "name": name,
          "gender": gender,
          "address": address,
          "hp": hp,
          "work": work,
          "iuran": iuran,
          "date": d,
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
            dateC.clear();
            Get.back();
            Get.back();
          },
          textConfirm: "Ok",
        );
      } catch (e) {
        print(e);
        Get.defaultDialog(
          title: "Failed",
          middleText: "Failed for adding Costumer!!",
          onConfirm: () => Get.back(),
          textConfirm: "Ok",
        );
      }
    });
  }

  @override
  void onInit() {
    nameC = TextEditingController();
    genderC = TextEditingController(text: "Laki-laki");
    addressC = TextEditingController();
    hpC = TextEditingController();
    workC = TextEditingController();
    iuranC = TextEditingController();
    dateC = TextEditingController();
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
    dateC.dispose();
    super.onClose();
  }
}
