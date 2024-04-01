import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/http_service.dart';

class HomeController extends GetxController {


  fetchImages() {
    HttpService.fetchImages();
  }

  void search(String text) {}

  void setSearchText(String text) {}

}