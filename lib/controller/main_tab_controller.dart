import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../page/favorite_page.dart';
import '../page/search_page.dart';

class MainTabController extends GetxController {
  int pageIndex = 0;
  Widget currentPage = const SearchPage();

  List<Widget> tabs = [
    const SearchPage(),
    const FavoritePage(),
  ];


  setPageIndex(int index) {
    debugPrint('setPageIndex : $index');
    pageIndex = index;
    currentPage = tabs[index];
    update();
  }

}