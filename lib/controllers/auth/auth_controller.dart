import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_authentication/data/repo/auth_repo.dart';
import 'package:flutter_authentication/views/screens/main_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  final AuthRepo _authRepo;
  AuthController(this._authRepo);
  final _storage = GetStorage();
  final _imagePicker = ImagePicker();

  var profileFile;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  /// login function

  void login({required String email, required String password}) async {
    final res = await _authRepo.login(email: email, password: password);
    res.fold((l) {
      Get.snackbar('Error', l);
    }, (r) {
      print(r);

      if (r['data'] == null) {
        Get.snackbar('Error', 'Something went wrong');
        return;
      }
      _storage.write('token', r['data']);
      Get.offAll(
        () => MainScreen(),
      );

      /// to main screen
      // save token to local storage
    });
  }

  /// pick images from gallery
  void pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    profileFile = File(pickedFile.path);
    update(['image']);
  }

  /// register function
  void registerUser(
      {required String name,
      required String email,
      required String password}) async {
    if (profileFile == null) {
      Get.snackbar('Error', 'Please select profile image');
      return;
    }

    final res = await _authRepo.register(
      name: name,
      email: email,
      password: password,
      profile: profileFile,
    );
    res.fold((l) {
      Get.snackbar('Error', l);
    }, (r) {
      /// show success message as dialog box of awesome dialog
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Success',
        desc: r,
        btnOkOnPress: () {
          Get.back();
        },
      ).show();

      /// do something
      // Get.back();
    });
  }
}
