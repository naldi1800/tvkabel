import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late TextEditingController searchC;
  var searchText = "".obs;
  RxList<QueryDocumentSnapshot<Object?>> allData =
      RxList<QueryDocumentSnapshot<Object?>>([]);
  late List<QueryDocumentSnapshot<Object?>> allDataCostumer;

  @override
  void onInit() {
    searchC = TextEditingController();
    super.onInit();
  }

  Stream<QuerySnapshot<Object?>> getData() {
    Query costumers = firestore.collection('costumers').orderBy('id');
    return costumers.snapshots();
  }

  void delete(String docID, String name) {
    DocumentReference doc = firestore.collection('costumers').doc(docID);
    try {
      Get.defaultDialog(
        title: "Delete",
        middleText: "Are you sure to delete this data '$name'",
        onConfirm: () async {
          await doc.delete();
          Get.back();
        },
        textConfirm: "Yes",
        textCancel: "No",
      );
    } catch (e) {
      print(e);
    }
  }

  void filter(String name) {
    List<QueryDocumentSnapshot<Object?>> res = [];
    if (name.isEmpty || name == "") {
      res = allDataCostumer;
    } else {
      res = allData
          .where((e) =>
              e['name'].toString().toLowerCase().contains(name.toLowerCase()) ||
              e['id'].toString().toLowerCase().contains(name.toLowerCase()))
          .toList();
    }
    allData.value = res;
  }

  @override
  void onClose() {
    super.onClose();
    searchC.dispose();
  }
}
