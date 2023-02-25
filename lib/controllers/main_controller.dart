import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainController extends GetxController {
  final _storage = GetStorage();
  bool isDarkMode = false;

  @override
  void onInit() {
    checkUserToken();
    super.onInit();
  }

  void checkUserToken() {
    final token = _storage.read('token');
    if (token != null) {
      return;
    } else {
      Get.offAllNamed('/login');
    }
  }

  void logout() {
    _storage.remove('token');
    Get.offAllNamed('/login');
  }

  /// switch theme
  void switchTheme() {
    // Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      isDarkMode = false;
    } else {
      isDarkMode = true;
      Get.changeThemeMode(ThemeMode.dark);
    }
    update();
  }
}
