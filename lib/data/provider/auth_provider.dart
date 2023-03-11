import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_authentication/constant/constant.dart';
import 'dart:io';

import 'package:flutter_authentication/data/models/user/current_user_res_model.dart';
import 'package:get_storage/get_storage.dart';

class AuthProvider {
  final _storage = GetStorage();

  final Dio _dio;
  AuthProvider(this._dio);
  Future<Either<String, dynamic>> login(
      {required String email, required String password}) async {
    try {
      final res = await _dio.post(
        '$kBaseUrl/login',
        data: {'email': email, 'password': password},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (res.statusCode == 200) {
        return Right(res.data);
      } else {
        return Left('Something went wrong');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// register user function

  Future<Either<String, String>> register(
      {required String email,
      required String name,
      required String password,
      required File profile}) async {
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(profile.path),
        'email': email,
        'password': password,
        'name': name,
      });
      final res = await _dio.post(
        '$kBaseUrl/register',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (res.statusCode == 200) {
        return Right("User registered successfully");
      } else {
        return Left('Something went wrong');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// get me
  Future<Either<String, CurrentUserResModel>> getMe() async {
    try {
      final res = await _dio.get(
        '$kBaseUrl/user/me',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${_storage.read('token')}'
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (res.statusCode == 200) {
        return Right(CurrentUserResModel.fromJson(res.data));
      } else {
        return Left('Something went wrong');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// update user
  Future<Either<String, String>> updateUser(
      {String? name, File? profile, required String id}) async {
    var formData = FormData();
    if (name != null) {
      formData.fields.add(MapEntry('name', name));
    }
    if (profile != null) {
      formData.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(profile.path),
      ));
    }
    final res = await _dio.post(
      '$kBaseUrl/user/update/$id',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    if (res.statusCode == 200) {
      return Right('User updated successfully');
    } else {
      return Left('Something went wrong');
    }
  }

  Future<Either<String, String>> logout() async {
    final res = await _dio.post("${kBaseUrl}/logout",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_storage.read('token')}'
        }));

    if (res.statusCode == 200) {
      return Right('User logout successfully');
    } else {
      return Left('Something went wrong');
    }
  }
}
