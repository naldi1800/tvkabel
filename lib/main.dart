import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tvkabel/app/controllers/auth_controller.dart';
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
    return StreamBuilder<User?>(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.connectionState == ConnectionState.active) {
          return FutureBuilder(
            future: Future.delayed(Duration(seconds: 3)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GetMaterialApp(
                  title: "Application",
                  initialRoute:
                      (snapshot.data != null) ? Routes.HOME : Routes.LOGIN,
                  getPages: AppPages.routes,
                  debugShowCheckedModeBanner: false,
                );
              }
              return SplashScreen();
            },
          );
        }
        return LoadingScreen();
      },
    );
  }
}
