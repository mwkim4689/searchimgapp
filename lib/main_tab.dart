import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/main_tab_controller.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  MainTabController mainTabController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainTabController>(builder: (_) {
        return _.tabs[_.pageIndex];
      }),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "검색",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_rounded),
            label: "즐겨찾기",
          ),
        ],
        currentIndex: mainTabController.pageIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color(0xFFCBCBCB),
        onTap: mainTabController.setPageIndex,
      ),
    );
  }
}
