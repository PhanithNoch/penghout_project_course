import 'package:flutter_authentication/data/repo/post_repo.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreatePostController extends GetxController {
  final picker = ImagePicker();
  final PostRepo _postRepo;
  final _storage = GetStorage();

  CreatePostController(this._postRepo);

  void clearToken() {
    _storage.remove('token');
  }

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

  /// upload post
  void uploadPost({required String caption}) async {
    final res = await _postRepo.createPost(caption: caption, file: profileFile);
    res.fold((l) {
      Get.snackbar('Error', l);
    }, (r) {
      Get.back(result: true);
    });
  }
}
