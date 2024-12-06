import 'package:flutter/material.dart';
import 'package:getx_na_pratica/app/modules/core/bindings/core_binding.dart';

import 'app_widget.dart';

Future<void> main() async {
  await initStorage();
  runApp(const AppWidget());
}
