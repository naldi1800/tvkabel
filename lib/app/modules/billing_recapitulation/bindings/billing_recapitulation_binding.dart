import 'package:get/get.dart';

import '../controllers/billing_recapitulation_controller.dart';

class BillingRecapitulationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillingRecapitulationController>(
      () => BillingRecapitulationController(),
    );
  }
}
