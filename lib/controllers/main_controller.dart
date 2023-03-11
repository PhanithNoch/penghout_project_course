import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_authentication/data/models/user/current_user_res_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:either_dart/either.dart';
import '../data/repo/auth_repo.dart';

class MainController extends GetxController {
  final _storage = GetStorage();
  bool isDarkMode = false;
  AuthRepo _authRepo;
  MainController(this._authRepo);
  CurrentUserResModel currentUser = CurrentUserResModel();

  @override
  void onInit() {
    checkUserToken();
    getCurrentUser();
    super.onInit();
  }

  /// get current user logged
  void getCurrentUser() async {
    final res = _authRepo.getCurrentUser();
    res.fold((l) {
      Get.snackbar('Error', l);
    }, (r) {
      currentUser = r;
      print(jsonEncode(r.toJson()));
      print(r);
    });
  }

  void checkUserToken() {
    final token = _storage.read('token');
    if (token != null) {
      return;
    } else {
      Get.offAllNamed('/login');
    }
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

//  logout function
  void logout() async {
    final res = await _authRepo.logout();
    res.fold((l) {
      Get.snackbar('Error', l);
    }, (r) {
      _storage.remove('token');
      Get.offAllNamed('/login');
    });
  }
}
