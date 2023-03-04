import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../../data/provider/auth_provider.dart';
import '../../data/repo/auth_repo.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final controller = Get.put(ProfileController(AuthRepo(AuthProvider(Dio()))));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<ProfileController>(
                      id: 'image',
                      builder: (controller) {
                        if (controller.currentUser.data!.image == null) {
                          return CircleAvatar(
                            radius: 50,
                            child: Icon(Icons.person),
                          );
                        }
                        if (controller.localProfile != null)
                          return Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    FileImage(controller.localProfile!),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    color: Colors.green,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      controller.pickImage();
                                    },
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        return Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                '${controller.currentUser.data!.image}',
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  color: Colors.green,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    controller.pickImage();
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: controller.emailController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Email',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(Icons.email),
                ),
              ),

              /// adding a button to update profile
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.updateProfile();
                },
                child: Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
