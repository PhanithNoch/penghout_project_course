import 'package:either_dart/either.dart';

import '../models/user/current_user_res_model.dart';
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

  /// get current user function
  Future<Either<String, CurrentUserResModel>> getCurrentUser() async {
    return await _authProvider.getMe();
  }

  /// update user
  Future<Either<String, String>> updateUser(
      {String? name, File? profile, required String id}) async {
    return await _authProvider.updateUser(name: name, profile: profile, id: id);
  }
}
