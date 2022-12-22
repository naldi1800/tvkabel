import 'package:get/get.dart';
import 'package:tvkabel/app/routes/app_pages.dart';

class HomeController extends GetxController {
  var menuItem = [
    "Data Pelanggan",
    "Penagihan Pelanggan", // Pencarian, form (tanggal dan)
    "Riwayat", // History Pembayaran Harian
    "Semua Penagihan", // Rekapitulasi (Analog, Digital)
    "Tentang", // informasi sederhana mengenai source code dan create by
  ];

  void onClickMenuItem(int index) {
    switch (index) {
      case 0:
        {
          Get.toNamed(Routes.CUSTOMER);
        }
        break;
      case 1:
        {
          Get.toNamed(Routes.BILLING);
        }
        break;
      case 2:
        {
          Get.toNamed(Routes.HISTORY);
        }
        break;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
