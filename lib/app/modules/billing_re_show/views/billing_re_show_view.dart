import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

import '../controllers/billing_re_show_controller.dart';

class BillingReShowView extends GetView<BillingReShowController> {
  const BillingReShowView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recapitulation'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Pilih Bulan",
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: controller.monthYears,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Enter a message',
                prefixIcon: IconButton(
                  onPressed: () async {
                    var my =
                        await SimpleMonthYearPicker.showMonthYearPickerDialog(
                      context: context,
                      barrierDismissible: true,
                    );
                    my = DateFormat("yyyy-MM").format(my);
                    controller.monthYears.text = my;
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ),
            ),
            ElevatedButton(
              child: const Text("Lihat Rekapan"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
