import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BillingReShowController extends GetxController {
  late List<int> month;
  late List<int> years;
  late TextEditingController monthYears;

  @override
  void onInit() {
    super.onInit();
    month = List.generate(12, (index) => index + 1);
    years = [];

    for (var i = 2010; i < DateTime.now().year; i++) {
      years.add(i);
    }
    monthYears = TextEditingController();
    // monthC =
  }

  @override
  void onClose() {
    super.onClose();
    monthYears.dispose();
  }
}
