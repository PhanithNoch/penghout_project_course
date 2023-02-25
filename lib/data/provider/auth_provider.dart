import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_authentication/constant/constant.dart';
import 'dart:io';

class AuthProvider {
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
}
