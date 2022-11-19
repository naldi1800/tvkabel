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
        body: ListView.builder(
          itemCount: controller.menuItem.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.transparent,
              child: ListTile(
                title: Text(controller.menuItem[index]),
                onTap: () => {
                  controller.onClickMenuItem(index),
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
