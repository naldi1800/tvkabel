import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tvkabel/app/utils/ui.dart';

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

  void getPembayaran(Timestamp date, String id) async {
    // var dt = DateFormat('yyyy-MM-dd').format(date.toDate());
    var dt = date.toDate();
    var now = DateTime.now();
    var bln = Jiffy([now.year, now.month, now.day])
        .diff(Jiffy([dt.year, dt.month, dt.day]), Units.MONTH);
    print(bln);
    print(dt);
    print(now);

    // int t =
    //     now.millisecondsSinceEpoch - DateTime.parse(dt).millisecondsSinceEpoch;
    // var dates = t / (3600 * 24 * 12);

    // Duration diff = now.difference(dt);
    // // print(diff.in);
    // int bln = (diff.inDays ~/ 30).toInt();
    // print(bln);
    List<String> bills = [];
    for (var i = 1; i <= bln; i++) {
      var to = Jiffy([dt.year, dt.month, dt.day]).add(months: i);
      print(to);
      bills.add("${to.year}-${to.month}");
      // var toBill = DateTime(
      //   dt.year,
      //   dt.month + i,
      //   dt.day,
      // );
      // bills.add(DateFormat("yyyy-MM").format(toBill));
    }

    // print("${diff.inDays} Hari | $bln Bulan");

    print(bills);

    Query bill =
        firestore.collection("billings").where('id_customer', isEqualTo: id);
    bill.get().then((value) {
      // print("oke");
      value.docs.forEach((element) {
        var data = element.data() as Map<String, dynamic>;
        var blnByr = data['bulan_bayar'];
        for (var i = 0; i < bills.length; i++) {
          if (bills[i] == blnByr) {
            bills.removeAt(i);
          }
        }
        // print(bills[index] == blnByr);
        print(blnByr);
      });
      for (var i = 0; i < bills.length; i++) {
        item.value.add({
          'value': bills[i],
          'label': bills[i],
        });
      }
      print(item.value.map((e) => Map<String, dynamic>.from(e)).toSet());
    });
    await Future.delayed(const Duration(seconds: 3));
    if (item.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Get.defaultDialog(
          title: "Info",
          middleText: "Tidak ada pembayaran tersedia",
          backgroundColor: ui.foreground,
          titleStyle: TextStyle(color: ui.object),
          middleTextStyle: TextStyle(color: ui.object),
          onConfirm: () {
            Get.back();
            Get.back();
          },
          textConfirm: "Ok",
        );
      });
    }
  }

  void add(String id, String bulan) async {
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
        backgroundColor: ui.foreground,
        titleStyle: TextStyle(color: ui.object),
        middleTextStyle: TextStyle(color: ui.object),
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
        backgroundColor: ui.foreground,
        titleStyle: TextStyle(color: ui.object),
        middleTextStyle: TextStyle(color: ui.object),
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
