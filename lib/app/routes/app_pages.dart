import 'package:get/get.dart';

import '../modules/addCustomer/bindings/add_customer_binding.dart';
import '../modules/addCustomer/views/add_customer_view.dart';
import '../modules/customer/bindings/customer_binding.dart';
import '../modules/customer/views/customer_view.dart';
import '../modules/detailCustomer/bindings/detail_customer_binding.dart';
import '../modules/detailCustomer/views/detail_customer_view.dart';
import '../modules/editCustomer/bindings/edit_customer_binding.dart';
import '../modules/editCustomer/views/edit_customer_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const Home = Routes.HOME;
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
  ];
}
