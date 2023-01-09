import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tvkabel/app/controllers/auth_controller.dart';
import 'package:tvkabel/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';
import 'package:tvkabel/app/utils/ui.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();

  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var styleContactPerson = const TextStyle(
      fontFamily: 'arvo',
      fontSize: 20,
      color: ui.object,
    );
    controller.getData();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: ui.background,
              child: Container(),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  height: height * 0.21,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: ui.foreground,
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      Text(
                        "Kadun Jaya TV Kabel".toUpperCase(),
                        style: const TextStyle(
                            fontFamily: 'EastSea',
                            fontSize: 30,
                            color: ui.object),
                      ),
                      const SizedBox(height: 15),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            itemInfo(context,
                                name: "Pelanggan",
                                jml: controller.p.value,
                                onTapAction: 1),
                            itemInfo(context,
                                name: "Total Pembayaran",
                                jml: controller.m.value,
                                onTapAction: 2),
                            // itemInfo(
                            //   context,
                            //   name: "Belum",
                            //   jml: 5,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.1),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    height: height * 0.33,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: ui.foreground,
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: controller.menuItem.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(12),
                          color: ui.action,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                controller.onClickMenuItem(index, context),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    controller.menuItem[index]['icon']
                                        as IconData,
                                    color: ui.object,
                                    size: 45,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "${controller.menuItem[index]['title']}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'arvo',
                                    color: ui.object,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: height * 0.1),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    height: height * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: ui.foreground,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          minRadius: 50,
                          maxRadius: 70,
                          child: Image(
                            image: AssetImage(
                              'assets/images/logo.png',
                            ),
                            color: ui.object,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Nurul Khotimah",
                              style: styleContactPerson,
                            ),
                            Text(
                              "201024",
                              style: styleContactPerson,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget itemInfo(BuildContext context,
      {required int jml, required String name, int onTapAction = 0}) {
    TextStyle style = const TextStyle(color: ui.object, fontFamily: 'arvo');
    return GestureDetector(
      onTap: () {
        switch (onTapAction) {
          case 1:
            Get.toNamed(Routes.CUSTOMER);
            break;
          case 2:
            Get.toNamed(Routes.BILLING);
            break;
        }
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: ui.action,
            child: Text(
              "${jml}",
              style: style,
            ),
          ),
          const SizedBox(height: 2),
          Text("$name", style: style),
        ],
      ),
    );
  }
}
