import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../data/models/user/current_user_res_model.dart';
import '../data/repo/auth_repo.dart';

class ProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  File? localProfile;
  String? profile;
  AuthRepo _authRepo;
  ProfileController(this._authRepo);
  CurrentUserResModel currentUser = CurrentUserResModel();
  final picker = ImagePicker();

  initData() {}
  @override
  void onInit() {
    final ar = Get.arguments;
    if (ar != null) {
      currentUser = ar;
      nameController.text = currentUser.data!.name!;
      emailController.text = currentUser.data!.email!;
      profile = currentUser.data?.image;
    }
    super.onInit();
  }

  void updateProfile() async {
    final res = await _authRepo.updateUser(
      name: nameController.text,
      profile: localProfile,
      id: currentUser.data!.id.toString(),
    );
    res.fold((l) {
      /// show message error as awesome dialog
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Error',
        desc: l,
        btnOkOnPress: () {},
      )..show();
    }, (r) {
      /// show success message as dialog box of awesome dialog
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.SUCCES,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Success',
        desc: r,
        btnOkOnPress: () {
          Get.back(result: true);
        },
      )..show();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    localProfile = File(pickedFile.path);
    update(['image']);
  }
}
