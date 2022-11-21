import 'package:get/get.dart';

import '../controllers/detail_customer_controller.dart';

class DetailCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailCustomerController>(
      () => DetailCustomerController(),
    );
  }
}
