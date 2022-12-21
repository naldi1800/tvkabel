import 'package:get/get.dart';

import '../controllers/add_billing_controller.dart';

class AddBillingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBillingController>(
      () => AddBillingController(),
    );
  }
}
