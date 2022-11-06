import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  TextEditingController userC = TextEditingController(text: 'nurul@gmail.com');
  TextEditingController passC = TextEditingController(text: '123123');

  @override
  void onClose() {
    userC.dispose();
    passC.dispose();
    super.onClose();
  }
}
