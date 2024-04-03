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
  // Get.lazyPut은 인스턴스를 필요로 하는 시점까지 생성을 지연시킴으로써
  // 메모리 사용을 최적화하기 위해 사용함
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => FavoriteController());
  Get.lazyPut(() => MainTabController());
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