import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: const [
            Text(
              'Aplikasi Kadun Jaya TV Kabel dibuat menggunakan bahasa pemograman Dart dengan Flutter sebagai Framework Utama. Tujuan aplikasi ini dibuat adalah untuk memudahkan dalam pencatatan bukti pembayaran tagihan tv kabel pada Kadun Jaya TV Kabel',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Created by Nurul | Stb copyright 2022',
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
