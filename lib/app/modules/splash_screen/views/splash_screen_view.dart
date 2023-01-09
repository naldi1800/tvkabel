import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: 350,
                height: 350,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            Image.asset('assets/images/welcome..jpg'),
          ],
        ),
      ),
    );
  }
}
