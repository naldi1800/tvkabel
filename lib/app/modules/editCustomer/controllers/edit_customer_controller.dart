import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tvkabel/app/routes/app_pages.dart';

class EditCustomerController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController genderC;
  late TextEditingController addressC;
  late TextEditingController hpC;
  late TextEditingController workC;
  late TextEditingController iuranC;
  late TextEditingController dateC;

  var genders = "Laki-laki".obs;
  var paket = {}.obs;
  var paketForSelect = [].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Object?>> getData(String docID) {
    DocumentReference doc = firestore.collection('costumers').doc(docID);
    return doc.snapshots();
  }

  void getPakets() {
    Query v = firestore.collection('packets').orderBy('price');
    v.get().then((value) {
      paketForSelect.value = [];
      value.docs.forEach((element) {
        var x = element.data() as Map<String, dynamic>;
        paketForSelect.add({
          'value': element.id,
          'label': "${x['name']} - ${x['price']}",
        });
      });
    });
  }

  void setGender(RxString v) {
    genderC.text = v.value;
    genders.value = v.value;
  }

  void getPaket(String docID) {
    DocumentReference doc = firestore.collection('packets').doc(docID);
    doc
        .get()
        .then((value) => paket.value = value.data() as Map<String, dynamic>);
  }

  void edit(String name, String gender, String address, String hp, String work,
      String iuran, String date, String docID) async {
    DocumentReference doc = firestore.collection('costumers').doc(docID);
    DateTime d = DateTime.parse(date);
    try {
      await doc.update({
        "name": name,
        "gender": gender,
        "address": address,
        "hp": hp,
        "work": work,
        "date": d,
      });

      Get.defaultDialog(
        title: "Success",
        middleText: "Success for editing Costumer",
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
      Get.defaultDialog(
        title: "Failed",
        middleText: "Failed for editing Costumer!!",
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
