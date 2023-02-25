import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final _storage = GetStorage();
  @override
  void onInit() {
    initSlashScreen();
    super.onInit();
  }

  void initSlashScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    checkUserToken();
  }

  void checkUserToken() {
    final token = _storage.read('token');
    if (token != null) {
      Get.offNamed('/main');
      return;
    } else {
      /// navigate to choose language screen
      Get.offNamed('/language');
      // Get.offAllNamed('/login');
    }
  }
}
