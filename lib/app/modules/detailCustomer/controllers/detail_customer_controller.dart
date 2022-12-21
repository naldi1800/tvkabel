import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailCustomerController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var paket = {}.obs;

  Stream<DocumentSnapshot<Object?>> getData(String docID) {
    DocumentReference doc = firestore.collection('costumers').doc(docID);
    return doc.snapshots();
  }

  void getPaket(String docID) {
    DocumentReference doc = firestore.collection('packets').doc(docID);
    doc
        .get()
        .then((value) => paket.value = value.data() as Map<String, dynamic>);
  }

  void delete(String docID) {
    DocumentReference doc = firestore.collection('costumers').doc(docID);
    try {
      Get.defaultDialog(
        title: "Delete",
        middleText: "Are you sure to delete this data",
        onConfirm: () async {
          await doc.delete();
          Get.back();
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
