import 'package:dio/dio.dart';
import 'package:flutter_authentication/data/provider/post_provider.dart';
import 'package:get/get.dart';

import '../controllers/post/create_post_controller.dart';
import '../data/repo/post_repo.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePostController>(
      () => CreatePostController(PostRepo(PostProvider(Dio()))),
      fenix: true,
    );
  }
}
