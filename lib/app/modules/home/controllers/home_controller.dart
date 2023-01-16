import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';
import 'package:tvkabel/app/controllers/auth_controller.dart';
import 'package:tvkabel/app/routes/app_pages.dart';
import 'package:tvkabel/app/utils/ui.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late TextEditingController monthYears;
  var p = 0.obs, m = 0.obs, b = 0.obs;

  final authC = Get.find<AuthController>();
  void getData() {
    Query costumers = firestore.collection('costumers').orderBy('id');
    costumers.get().then(
      (value) {
        p.value = value.size;
      },
    );
    Query billing = firestore.collection('billings');
    billing.get().then(
      (value) {
        m.value = value.size;
        print(value.size);
      },
    );
    // return costumers.snapshots();
  }

  @override
  void onInit() {
    monthYears = TextEditingController(
      text: DateFormat("yyyy-MM").format(DateTime.now()),
    );
    super.onInit();
  }

  var menuItem = [
    {
      "title": "Data Pelanggan",
      "icon": CupertinoIcons.person,
    },
    {
      "title": "Penagihan Pelanggan",
      "icon": Icons.payment,
    },
    {
      "title": "Semua Penagihan",
      "icon": Icons.payments,
    },
    {
      "title": "Riwayat",
      "icon": Icons.history,
    },
    {
      "title": "Tentang",
      "icon": CupertinoIcons.info,
    },
    {
      "title": "Logout",
      "icon": Icons.logout,
    },
  ];

  void onClickMenuItem(int index, BuildContext context) async {
    switch (index) {
      case 0:
        {
          Get.toNamed(Routes.CUSTOMER);
        }
        break;
      case 1:
        {
          Get.toNamed(Routes.BILLING);
        }
        break;
      case 3:
        {
          Get.toNamed(Routes.HISTORY);
        }
        break;
      case 2:
        {
          Get.defaultDialog(
            title: "Select Month",
            backgroundColor: ui.foreground,
            titleStyle: TextStyle(fontFamily: 'arvo', color: ui.object),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: monthYears,
                  readOnly: true,
                  style: TextStyle(color: ui.object),
                  decoration: InputDecoration(
                    hintText: 'Pilih Bulan',
                    hintStyle: TextStyle(color: ui.action),
                    border: InputBorder.none,
                    prefixIcon: IconButton(
                      onPressed: () async {
                        var my = await SimpleMonthYearPicker
                            .showMonthYearPickerDialog(
                          context: context,
                          barrierDismissible: true,
                        );
                        monthYears.text = DateFormat("yyyy-MM").format(my);
                      },
                      icon: const Icon(
                        Icons.calendar_month,
                        color: ui.action,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(ui.action)),
                  child: const Text(
                    "Lihat Rekapan",
                    style: TextStyle(fontFamily: 'arvo', color: ui.object),
                  ),
                  onPressed: () {
                    Get.back();
                    Get.toNamed(Routes.BILLING_RECAPITULATION,
                        arguments: monthYears.text);
                  },
                ),
              ],
            ),
          );
          // var my = await SimpleMonthYearPicker.showMonthYearPickerDialog(
          //   context: context,
          //   barrierDismissible: true,
          // );
          // my = DateFormat("yyyy-MM").format(my);
        }
        break;
      case 4:
        {
          Get.toNamed(Routes.ABOUT);
        }
        break;
      case 5:
        {
          authC.logout();
        }
        break;
    }
  }

  @override
  void onClose() {
    super.onClose();
    monthYears.dispose();
  }
}
