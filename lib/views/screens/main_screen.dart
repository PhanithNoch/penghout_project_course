import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/data/provider/auth_provider.dart';
import 'package:flutter_authentication/data/repo/auth_repo.dart';
import 'package:flutter_authentication/views/screens/profile_screen.dart';
import 'package:flutter_authentication/views/screens/upload_photo_screen.dart';
import 'package:get/get.dart';

import '../../controllers/main_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final controller = Get.put(MainController(AuthRepo(AuthProvider(Dio()))));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: GetBuilder<MainController>(
          builder: (controller) => ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  controller.currentUser.data?.name ?? '',
                ),
                accountEmail: Text(
                  '${controller.currentUser.data!.email}',
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                    controller.currentUser.data!.image!,
                  ),
                ),
              ),

              ListTile(
                title: Text('Home'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: Text('Profile'),
                onTap: () async {
                  await Get.to(
                    () => ProfileScreen(),
                    arguments: controller.currentUser,
                  );
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Get.back();
                  controller.getCurrentUser();
                },
                trailing: Icon(Icons.arrow_forward_ios),
              ),

              /// switch theme button here
              ListTile(
                title: Text('change_theme'.tr),
                trailing: ToggleButtons(
                  children: [
                    Icon(Icons.light_mode),
                    Icon(Icons.dark_mode),
                  ],
                  isSelected: [true, false],
                  onPressed: (index) {
                    Get.changeThemeMode(
                      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                    );
                  },
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () => controller.logout(),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        )),
        appBar: AppBar(
          title: Text('Main Screen'),
          actions: [
            /// adding logout button here
            IconButton(
              onPressed: () => controller.logout(),
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Column(
          children: [
            Divider(
              height: 1,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.blue),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        print('tapped');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.text_decrease),
                          Text('Status'),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => UploadPhotoScreen());
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.photo,
                            color: Colors.white,
                          ),
                          Text(
                            'Photos',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
