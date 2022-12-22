import 'package:get/get.dart';

import '../modules/addCustomer/bindings/add_customer_binding.dart';
import '../modules/addCustomer/views/add_customer_view.dart';
import '../modules/add_billing/bindings/add_billing_binding.dart';
import '../modules/add_billing/views/add_billing_view.dart';
import '../modules/billing/bindings/billing_binding.dart';
import '../modules/billing/views/billing_view.dart';
import '../modules/customer/bindings/customer_binding.dart';
import '../modules/customer/views/customer_view.dart';
import '../modules/detailCustomer/bindings/detail_customer_binding.dart';
import '../modules/detailCustomer/views/detail_customer_view.dart';
import '../modules/editCustomer/bindings/edit_customer_binding.dart';
import '../modules/editCustomer/views/edit_customer_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/sub_main/bindings/sub_main_binding.dart';
import '../modules/sub_main/views/sub_main_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;
  // static const Login = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER,
      page: () => const CustomerView(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CUSTOMER,
      page: () => AddCustomerView(),
      binding: AddCustomerBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_CUSTOMER,
      page: () => const EditCustomerView(),
      binding: EditCustomerBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_CUSTOMER,
      page: () => const DetailCustomerView(),
      binding: DetailCustomerBinding(),
    ),
    GetPage(
      name: _Paths.BILLING,
      page: () => const BillingView(),
      binding: BillingBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.SUB_MAIN,
      page: () => SubMainView(),
      binding: SubMainBinding(),
    ),
    GetPage(
      name: _Paths.ADD_BILLING,
      page: () => const AddBillingView(),
      binding: AddBillingBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
  ];
}
