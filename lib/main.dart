import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tvkabel/app/controllers/auth_controller.dart';
import 'package:tvkabel/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:tvkabel/app/utils/LoadingScreen.dart';
import 'package:tvkabel/app/utils/SplashScreen.dart';

import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      onReady: () {
        print("Start");
        Future.delayed(const Duration(seconds: 3), () {
          print("End");
          Get.offAllNamed(Routes.SUB_MAIN);
        });
      },
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
