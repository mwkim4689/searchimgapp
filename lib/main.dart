import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchimgapp/controller/favorite_controller.dart';
import 'package:searchimgapp/controller/home_controller.dart';
import 'package:searchimgapp/main_tab.dart';
import 'package:searchimgapp/style/theme_data.dart';

import 'controller/main_tab_controller.dart';
void main() {

  initGetX();

  runApp(const MyApp());
}

void initGetX() {
  Get.put(HomeController());
  Get.put(FavoriteController());
  Get.put(MainTabController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ImgSearch',
      theme: appThemeData(context),
      home: const MainTab(),
    );
  }
}