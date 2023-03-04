import 'package:flutter/material.dart';
import 'package:flutter_authentication/views/screens/get_location_lat_lng.dart';
import 'package:flutter_authentication/views/screens/get_location_page.dart';
import 'package:flutter_authentication/views/screens/language_screen.dart';
import 'package:flutter_authentication/views/screens/location_screen.dart';
import 'package:flutter_authentication/views/screens/login_screen.dart';
import 'package:flutter_authentication/views/screens/main_screen.dart';
import 'package:flutter_authentication/views/screens/profile_screen.dart';
import 'package:flutter_authentication/views/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bindings/auth_binding.dart';
import 'localizations/languages.dart';

void main() async {
  await GetStorage.init();

  runApp(const MyApp());
}

ThemeData _darkTheme = ThemeData(
    fontFamily: 'Battambang',
    accentColor: Colors.red,
    brightness: Brightness.dark,
    primaryColor: Colors.amber,
    backgroundColor: Colors.red,
    appBarTheme: AppBarTheme(
      // color: Colors.red,
      elevation: 0,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.amber,
      disabledColor: Colors.grey,
    ));

ThemeData _lightTheme = ThemeData(
  fontFamily: 'Battambang',
  accentColor: Colors.pink,
  // brightness: Brightness.light,
  primaryColor: Colors.pink,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.pink,
    disabledColor: Colors.grey,
  ),
  appBarTheme: AppBarTheme(
    // color: Colors.red,
    elevation: 0,
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Languages(),
      initialBinding: AuthBinding(),
      locale: Get.deviceLocale,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      // themeMode: ThemeMode.system,

      fallbackLocale: const Locale('en', 'US'),
      title: 'Flutter Demo',
      // home: MainScreen(),
      // home: MainScreen(),
      // initialRoute: 'main',
      home: SplashScreen(),
      // home: LanguagesScreen(),
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/main',
          page: () => MainScreen(),
          transition: Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/language',
          page: () => LanguagesScreen(),
          transition: Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
      ],
    );
  }
}
