import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '/app/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final authC = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: Routes.SUB_MAIN, //Routes.SplashScreen
      supportedLocales: const [
        Locale('en'),
      ],
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
