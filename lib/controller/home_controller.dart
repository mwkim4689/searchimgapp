import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:searchimgapp/data/response/documents_response.dart';

import '../data/entity/document_entity.dart';
import '../data/entity/meta_entity.dart';
import '../service/http_service.dart';

class HomeController extends GetxController {
  TextEditingController searchTextController = TextEditingController(text: "");

  ScrollController scrollController = ScrollController(
    // keepScrollOffset: false,
  );

  List<DocumentEntity> documentList = [];
  MetaEntity? meta;

  int pageNum = 1;
  int pageSize = 3;

  @override
  void onInit() {
    debugPrint("HomeController onInit");
    scrollController.addListener(scrollListener);
  }

  scrollListener() {
    debugPrint("scrollListener called");
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      debugPrint("scrollListener, in");
      searchMore();
    }
  }

  Future<void> search() async {

    debugPrint("HomeController, search called");

    documentList.clear();
    pageNum = 1;

    DocumentsResponse documentsResponse =
        await HttpService.fetchImages(searchText: searchTextController.text, page: pageNum, size: pageSize);

    meta = documentsResponse.meta;

    documentList = documentsResponse.documents;

    update();

  }

  Future<void> searchMore() async {

    debugPrint("HomeController, searchMore called");
    debugPrint("HomeController, searchMore, meta : ${meta}");
    debugPrint("HomeController, searchMore, meta : ${meta?.is_end}");

    if(meta?.is_end ?? true) {
      return;
    }

    debugPrint("HomeController, searchMore2 called");

    pageNum++;

    DocumentsResponse documentsResponse =
    await HttpService.fetchImages(searchText: searchTextController.text, page: pageNum, size: pageSize);

    meta = documentsResponse.meta;

    documentList.addAll(documentsResponse.documents);

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

  void setFavorite({required DocumentEntity document}) {
    document.isFavorite ^= true;
    update();



  }
}
