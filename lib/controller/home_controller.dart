import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:searchimgapp/data/response/documents_response.dart';

import '../data/entity/document_entity.dart';
import '../service/http_service.dart';

class HomeController extends GetxController {
  TextEditingController searchTextController = TextEditingController(text: "");

  List<DocumentEntity> documentList = [];

  Future<void> search() async {
    DocumentsResponse documentsResponse =
        await HttpService.fetchImages(searchText: searchTextController.text);

    documentList = documentsResponse.documents;

    update();

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
