import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomerController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Future<QuerySnapshot<Object?>> getData1() async {
  //   CollectionReference costumers = firestore.collection('costumers');
  //   return costumers.get();
  // }

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
}
