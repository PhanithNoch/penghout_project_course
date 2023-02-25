import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text('Drawer Header'),
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
            ),
          ],
        ),
      ),
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
      body: Center(
        child: Text('Main Screen'),
      ),
    );
  }
}
