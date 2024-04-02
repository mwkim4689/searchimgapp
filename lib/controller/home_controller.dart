import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:searchimgapp/controller/favorite_controller.dart';
import 'package:searchimgapp/controller/prefs_controller.dart';
import 'package:searchimgapp/data/response/documents_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/entity/document_entity.dart';
import '../data/entity/meta_entity.dart';
import '../service/http_service.dart';

class HomeController extends GetxController {
  TextEditingController searchTextController = TextEditingController(text: "");

  ScrollController scrollController = ScrollController();

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
      search(isInitialSearch: false);
    }
  }

  void setSearchText(String text) {
    searchTextController.text = text;
    update();
  }

  void clearSearchText() {
    searchTextController.text = "";
    update();
  }

  Future<void> search({bool isInitialSearch = false}) async {
    if (isInitialSearch) {
      documentList.clear();
      pageNum = 1;
    } else if (meta?.is_end ?? true) {
      return; // 마지막 페이지에 도달했으면 더 이상 데이터를 불러오지 않음
    } else {
      pageNum++; // 더 보기 요청 시 페이지 번호 증가
    }

    debugPrint("HomeController, search called, pageNum: $pageNum");

    DocumentsResponse documentsResponse = await HttpService.fetchImages(
        searchText: searchTextController.text, page: pageNum, size: pageSize);

    meta = documentsResponse.meta;

    if (isInitialSearch) {
      documentList = documentsResponse.documents;
    } else {
      documentList.addAll(documentsResponse.documents);
    }

    updateFavorite();

    update();
  }

  updateFavorite() async {
    List<DocumentEntity> favoriteDocs =
        await Get.find<PrefsController>().getFavoriteDocsFromPrefs();

    for (DocumentEntity doc in documentList) {
      for (DocumentEntity favDoc in favoriteDocs) {
        if (doc.image_url == favDoc.image_url) {
          doc.isFavorite = true;
        }
      }
    }
  }

  Future<void> setFavorite(
      {required DocumentEntity document, required bool isFavorite}) async {

    /// Home Page에서 즐겨찾기 On/Off
    document.isFavorite = isFavorite;


    /// 로컬에 favorite document list 상태 업데이트
    Get.find<PrefsController>()
        .setPrefsFavorite(document: document, isFavorite: isFavorite);


    /// Favorite Page 에서 즐겨찾기기 추가
    FavoriteController favoriteController = Get.find<FavoriteController>();
    if (isFavorite == true) {
      favoriteController.favoriteDocs.add(document.copyWith());
    } else {
      favoriteController.favoriteDocs
          .removeWhere((element) => element.image_url == document.image_url);
    }
    favoriteController.update();


    update();
  }

}
