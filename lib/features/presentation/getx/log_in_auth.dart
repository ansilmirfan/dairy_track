import 'dart:developer';

import 'package:dairy_track/features/data/data_source/firebase/data_source.dart';
import 'package:dairy_track/features/data/models/driver_model.dart';
import 'package:dairy_track/features/presentation/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class LogInAuth extends GetxController {
  final DataSource _dataSource = DataSource();
  var isLoggedIn = false.obs;
  var loading = false.obs;
  DriverModel? driver;

  void login(String user, String pass) async {
    if (user.trim().isEmpty && pass.trim().isEmpty) {
      showCustomSnackbar(
        title: "Login Failed",
        message: "Username and password are required.",
        isSuccess: false,
      );
    } else {
      loading.value = true;
      final result = await _dataSource.isValidUser(user, pass);
      if (result != null) {
        driver = result;
        log(driver.toString());
        isLoggedIn.value = true;
        showCustomSnackbar(
          title: "Login Successful",
          message: "Welcome back",
          isSuccess: true,
        );
      } else {
        isLoggedIn.value = false;
        showCustomSnackbar(
            title: "Login Failed",
            message: "Incorrect username or password.",
            isSuccess: false);
      }
      loading.value = false;
    }
  }
}
