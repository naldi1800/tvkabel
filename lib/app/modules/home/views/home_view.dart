import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:tvkabel/app/controllers/auth_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(actions: [
          IconButton(
            onPressed: () => authC.logout(),
            icon: Icon(
              Icons.logout,
            ),
          )
        ]),
        body: Column(
          children: const [
            Text("Welcome"),
            // S vgPicture.asset(
            //   'assets/images/top.svg',

            //   // color: Colors.blue,
            // ),
          ],
        ),
      ),
    );
  }
}
