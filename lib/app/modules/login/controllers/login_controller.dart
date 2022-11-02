import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  TextEditingController userC = TextEditingController(text: 'user@gmail.com');
  TextEditingController passC = TextEditingController(text: 'user1234');

  @override
  void onClose() {
    userC.dispose();
    passC.dispose();
    super.onClose();
  }
}
