import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '/app/controllers/auth_controller.dart';
import '/app/routes/app_pages.dart';

import '../controllers/sub_main_controller.dart';

class SubMainView extends GetView<SubMainController> {
  SubMainView({Key? key}) : super(key: key);
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () => print("eksekusi"));
    // StreamSubscription<T> listen()
    return Scaffold(
      // body: Center(child: CircularProgressIndicator()),
      body: StreamBuilder<User?>(
        stream: authC.streamAuthStatus,
        builder: (context, snStreamBuilder) {
          if (snStreamBuilder.connectionState == ConnectionState.active) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Get.offAllNamed(
                  (snStreamBuilder.data != null) ? Routes.HOME : Routes.LOGIN);
            });
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
