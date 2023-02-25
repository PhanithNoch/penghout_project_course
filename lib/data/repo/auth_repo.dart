import 'package:either_dart/either.dart';

import '../provider/auth_provider.dart';
import 'dart:io';

class AuthRepo {
  final AuthProvider _authProvider;
  AuthRepo(this._authProvider);
  Future login({required String email, required String password}) async {
    return await _authProvider.login(email: email, password: password);
  }

  Future<Either<String, String>> register(
      {required String email,
      required String name,
      required String password,
      required File profile}) async {
    return await _authProvider.register(
        email: email, name: name, password: password, profile: profile);
  }
}
