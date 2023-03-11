import 'package:either_dart/either.dart';

import '../provider/post_provider.dart';
import 'dart:io';

class PostRepo {
  final PostProvider _postProvider;
  PostRepo(this._postProvider);

  Future<Either<String, String>> createPost(
      {required String caption, File? file}) async {
    return await _postProvider.createPost(caption: caption, file: file);
  }
}
