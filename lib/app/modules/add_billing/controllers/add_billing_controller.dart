import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddBillingController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var paket = {}.obs;
  var item = [].obs;

  late TextEditingController idC;
  late TextEditingController dateC;
  late TextEditingController billingC;

  Future<DocumentSnapshot<Object?>> getData(String docID) async {
    DocumentReference doc = firestore.collection('costumers').doc(docID);
    return doc.get();
  }

  void getPaket(String docID) {
    DocumentReference doc = firestore.collection('packets').doc(docID);
    doc
        .get()
        .then((value) => paket.value = value.data() as Map<String, dynamic>);
  }

  void getPembayaran(Timestamp date, String id) {
    var dt = DateFormat('yyyy-MM-dd').format(date.toDate());
    var now = DateTime.now();

    // int t =
    //     now.millisecondsSinceEpoch - DateTime.parse(dt).millisecondsSinceEpoch;
    // var dates = t / (3600 * 24 * 12);
    var end = DateTime(
      DateTime.parse(dt).year,
      DateTime.parse(dt).month - 1,
      DateTime.parse(dt).day,
    );
    print(now);

    Query bill =
        firestore.collection("billings").where('id_customer', isEqualTo: id);
    bill.get().then((value) {
      print("oke");
      value.docs.forEach((element) {
        var data = element.data() as Map<String, dynamic>;
        var blnByr = data['bulan_bayar'];
        print(blnByr);
      });
    });
  }

  void add(String id, String date, String bulan) async {
    CollectionReference bill = firestore.collection("billings");

    try {
      await bill.add({
        "id_customer": id,
        "tanggal_pembayaran": DateTime.now(),
        "bulan_bayar": bulan,
      });

      Get.defaultDialog(
        title: "Success",
        middleText: "Success for adding Billing",
        onConfirm: () {
          idC.clear();
          dateC.clear();
          Get.back();
          Get.back();
        },
        textConfirm: "Ok",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Failed",
        middleText: "Failed for adding Billing!!",
        onConfirm: () => Get.back(),
        textConfirm: "Ok",
      );
    }
  }

  @override
  void onInit() {
    idC = TextEditingController();
    dateC = TextEditingController();
    billingC = TextEditingController(text: 'box');
    super.onInit();
  }

  @override
  void onClose() {
    idC.dispose();
    dateC.dispose();
    billingC.dispose();
    super.onClose();
  }
}
