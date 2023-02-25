import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/splash_controller.dart';

/// adding splash screen and loading screen here

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        children: [
          /// adding background image here
          Image.network(
            'https://boreypenghuoth.com/wp-content/uploads/2021/12/Jusmina_Modern_Villa_1.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            filterQuality: FilterQuality.high,
            width: double.infinity,
          ),

          /// adding color for blur background image here
          Container(
            color: Colors.black.withOpacity(0.7),
          ),

          /// welcome title

          /// adding logo here
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to GetX',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Login to continue',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text(
                  'Loading...',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
