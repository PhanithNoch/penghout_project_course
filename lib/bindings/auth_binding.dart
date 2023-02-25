import 'package:dio/dio.dart';
import 'package:flutter_authentication/data/provider/auth_provider.dart';
import 'package:flutter_authentication/data/repo/auth_repo.dart';
import 'package:get/get.dart';

import '../controllers/auth/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(
        AuthRepo(AuthProvider(Dio())),
      ),
      fenix: true,
    );
  }
}
