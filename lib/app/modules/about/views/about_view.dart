import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tvkabel/app/utils/ui.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tentang',
          style: TextStyle(color: ui.object, fontFamily: 'arvo'),
        ),
        centerTitle: true,
        backgroundColor: ui.foreground,
      ),
      backgroundColor: ui.background,
      body: Card(
        color: ui.foreground,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Aplikasi Kadun Jaya TV Kabel dibuat menggunakan bahasa pemograman Dart dengan Flutter sebagai Framework Utama. Tujuan aplikasi ini dibuat adalah untuk memudahkan dalam pencatatan bukti pembayaran tagihan tv kabel pada Kadun Jaya TV Kabel',
                style: TextStyle(
                  fontSize: 15,
                  color: ui.object,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10),
              Image(image: AssetImage('assets/images/profil.jpg')),
              SizedBox(height: 10),
              Text(
                'Created by Nurul Khotimah | 201024 copyright 2023',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: ui.object),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
