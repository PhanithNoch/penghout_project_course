import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreatePostController extends GetxController {
  final picker = ImagePicker();
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

  void pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    profileFile = File(pickedFile.path);
    update(['image']);
  }
}
