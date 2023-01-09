import 'package:get/get.dart';

import '../controllers/billing_re_show_controller.dart';

class BillingReShowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillingReShowController>(
      () => BillingReShowController(),
    );
  }
}
