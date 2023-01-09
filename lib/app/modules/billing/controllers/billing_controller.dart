import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BillingController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<QueryDocumentSnapshot<Object?>> allData =
      RxList<QueryDocumentSnapshot<Object?>>([]);
  late List<QueryDocumentSnapshot<Object?>> allDataCostumer;

  late TextEditingController searchC;

  @override
  void onInit() {
    searchC = TextEditingController();
    super.onInit();
  }

  Stream<QuerySnapshot<Object?>> getData() {
    CollectionReference costumers = firestore.collection('costumers');
    return costumers.snapshots();
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
