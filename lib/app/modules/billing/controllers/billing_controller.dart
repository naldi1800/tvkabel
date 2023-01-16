import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tvkabel/app/utils/ui.dart';

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
    Query costumers = firestore.collection('costumers').orderBy("id");
    return costumers.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getDataBilling() {
    Query costumers = firestore.collection('billings');
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

  void billingFilter() async {
    var list = allDataCostumer;
    List<QueryDocumentSnapshot<Object?>> res = [];
    // print(list.isEmpty);
    if (list.isEmpty) {
      res = allDataCostumer;
    } else {
      for (var i = 0; i < list.length; i++) {
        var map = list[i].data() as Map<String, dynamic>;
        bool cek = await get(map['date'], map['id']);
        print(cek);
        if (cek) {
          res.add(list[i]);
        }
      }
    }
    // print(res);
    await Future.delayed(Duration(seconds: 2));
    allData.value = res;
    // // print(res);
    // return res;
  }

  void filterWhereIfPayment() {
    List<QueryDocumentSnapshot<Object?>> res = [];

    // if (getPembayaran(date, id)) {
    // res = allDataCostumer;
    // } else {
    res = allData.where((e) {
      var a = getPembayaran(e['date'], e['id']);
      bool b = true;
      a.then((value) => b = value);
      return b;
    }).toList();
    // }
    allData.value = res;
  }

  Future<bool> get(Timestamp date, String id) async {
    var dt = date.toDate();
    var now = DateTime.now();
    var bln = Jiffy([now.year, now.month, now.day])
        .diff(Jiffy([dt.year, dt.month, dt.day]), Units.MONTH);
    List<String> bills = [];
    for (var i = 1; i <= bln; i++) {
      var to = Jiffy([dt.year, dt.month, dt.day]).add(months: i);
      bills.add("${to.year}-${to.month}");
    }
    QuerySnapshot cek = await firestore
        .collection("billings")
        .where('id_customer', isEqualTo: id)
        .get();

    int res = cek.docs.length;
    return res != bills.length;
    // print(cek);
  }

  Future<bool> getPembayaran(Timestamp date, String id) async {
    var item = [].obs;
    var dt = date.toDate();
    var now = DateTime.now();
    var bln = Jiffy([now.year, now.month, now.day])
        .diff(Jiffy([dt.year, dt.month, dt.day]), Units.MONTH);
    List<String> bills = [];
    for (var i = 1; i <= bln; i++) {
      var to = Jiffy([dt.year, dt.month, dt.day]).add(months: i);
      // print(to);
      bills.add("${to.year}-${to.month}");
    }

    // print(bills);

    Query bill =
        firestore.collection("billings").where('id_customer', isEqualTo: id);
    bill.get().then((value) {
      value.docs.forEach((element) {
        var data = element.data() as Map<String, dynamic>;
        var blnByr = data['bulan_bayar'];
        for (var i = 0; i < bills.length; i++) {
          if (bills[i] == blnByr) {
            bills.removeAt(i);
          }
        }
        print(blnByr);
      });
      for (var i = 0; i < bills.length; i++) {
        item.value.add(bills[i]);
      }
      // print(item.value.map((e) => Map<String, dynamic>.from(e)).toSet());
    });
    // await Future.delayed(const Duration(seconds: 1));
    return (item.isNotEmpty);
  }

  @override
  void onClose() {
    super.onClose();
    searchC.dispose();
  }
}
