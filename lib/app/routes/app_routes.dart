import 'package:get/get.dart';
import 'package:getx_na_pratica/app/modules/core/bindings/core_binding.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/pages/home_page.dart';

class AppRoutes {
  static const HOME = "/";

  static final INITIAL_BINDING = CoreBinding();

  static final routes = [
    GetPage(
      name: HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    )
  ];
}
