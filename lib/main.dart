import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchimgapp/controller/favorite_controller.dart';
import 'package:searchimgapp/controller/home_controller.dart';
import 'package:searchimgapp/main_tab.dart';

import 'controller/prefs_controller.dart';

void main() {

  initGetX();

  runApp(const MyApp());
}

void initGetX() {
  Get.put(HomeController());
  Get.put(FavoriteController());
  Get.put(PrefsController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SearchImgApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainTab(),
    );
  }
}