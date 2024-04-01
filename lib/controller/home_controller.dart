import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../service/http_service.dart';

class HomeController extends GetxController {

  TextEditingController searchTextController = TextEditingController(text: "");



  void search() {
    HttpService.fetchImages(searchText: searchTextController.text);
  }

  void setSearchText(String text) {
    searchTextController.text = text;
    update();
  }

  void clearSearchText() {
    searchTextController.text = "";
    update();
  }

}