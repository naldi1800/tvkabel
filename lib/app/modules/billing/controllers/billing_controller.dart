import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BillingController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> getData() {
    CollectionReference costumers = firestore.collection('costumers');
    return costumers.snapshots();
  }
}
