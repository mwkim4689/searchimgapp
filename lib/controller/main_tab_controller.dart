import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../page/favorite_page.dart';
import '../page/home_page.dart';

class MainTabController extends GetxController {
  int pageIndex = 0;
  Widget currentPage = const HomePage();

  List<Widget> tabs = [
    const HomePage(),
    const FavoritePage(),
  ];


  setPageIndex(int index) {
    pageIndex = index;
    currentPage = tabs[index];
    update();
  }

}