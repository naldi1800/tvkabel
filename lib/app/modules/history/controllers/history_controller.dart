import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> getData() {
    Query costumers = firestore
        .collection('billings')
        .orderBy("tanggal_pembayaran", descending: true);
    return costumers.snapshots();
  }
}
