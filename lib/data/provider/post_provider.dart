import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_authentication/constant/constant.dart';
import 'dart:io';

import 'package:get_storage/get_storage.dart';

class PostProvider {
  final _storage = GetStorage();

  final Dio _dio;
  PostProvider(this._dio);
  Future<Either<String, String>> createPost(
      {required String caption, File? file}) async {
    FormData formData = FormData.fromMap({
      'caption': caption,
    });
    if (file != null) {
      formData.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(file.path),
      ));
    }
    final res = await _dio.post("$kBaseUrl/posts",
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${_storage.read('token')}'
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ));
    if (res.statusCode == 200) {
      return Right("Post created successfully");
    } else {
      return Left('Something went wrong');
    }
  }
}
