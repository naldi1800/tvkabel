import 'package:get/get.dart';
import 'package:tvkabel/app/routes/app_pages.dart';

class HomeController extends GetxController {
  var menuItem = [
    "Data Pelanggan",
    "Data Pemesanan",
    "Data 3",
    "Data 4",
    "Data 5",
  ];

  void onClickMenuItem(int index) {
    switch (index) {
      case 0:
        {
          Get.toNamed(Routes.CUSTOMER);
        }
        break;
      default:
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
