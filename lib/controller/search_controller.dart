import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/http_service.dart';

class SearchController extends GetxController {


  fetchImages() {
    HttpService.fetchImages();
  }

}