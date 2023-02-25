import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/constant.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Choose your language', style: kTitleTextStyle),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.updateLocale(const Locale('en', 'US'));

              ///go to main screen
              Get.offAllNamed('/login');
            },
            child: const Text('English'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.updateLocale(const Locale('km', 'KH'));
              Get.offAllNamed('/login');
            },
            child: const Text('Khmer'),
          ),
        ],
      )),
    );
  }
}
