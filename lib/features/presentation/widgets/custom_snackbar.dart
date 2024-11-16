import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar({
  required String title,
  required String message,
  required bool isSuccess,
}) {

  Color backgroundColor = isSuccess ? Colors.green : Colors.red;
  Color textColor = isSuccess ? Colors.white : Colors.white;

  Get.snackbar(
    title,
    message,
    backgroundColor: backgroundColor,
    colorText: textColor,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(10),
    borderRadius: 10,
    duration: const Duration(seconds: 3),
  );
}
