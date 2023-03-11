import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/post/create_post_controller.dart';

class UploadPhotoScreen extends StatelessWidget {
  UploadPhotoScreen({Key? key}) : super(key: key);
  final controller = Get.put(CreatePostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
        actions: [
          /// add post button
          TextButton(
            onPressed: () {
              print('post button pressed');
              // controller.createPost();
            },
            child: Text(
              'Post',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "What's on your mind?",
                border: InputBorder.none,
              ),
            ),
          ),
          GetBuilder<CreatePostController>(
            id: 'image',
            builder: (controller) {
              if (controller.profileFile == null) {
                return Container();
              } else {
                return Image.file(
                  controller.profileFile!,
                  fit: BoxFit.cover,
                );
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.pickImage();
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
