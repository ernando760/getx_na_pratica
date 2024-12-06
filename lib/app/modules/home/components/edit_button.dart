import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key, this.onPressed, required this.label});
  final String label;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)))),
        child: Obx(() {
          if (controller.isLoading) {
            return const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 3));
          }
          return Text(label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ));
        }));
  }
}
