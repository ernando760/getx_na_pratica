import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.HOME,
      initialBinding: AppRoutes.INITIAL_BINDING,
      getPages: AppRoutes.routes,
    );
  }
}
