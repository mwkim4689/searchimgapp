import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:searchimgapp/controller/favorite_controller.dart';
import 'package:searchimgapp/controller/prefs_controller.dart';
import 'package:searchimgapp/data/response/documents_response.dart';

import '../data/entity/document_entity.dart';
import '../data/entity/meta_entity.dart';
import '../service/http_service.dart';

class HomeController extends GetxController {
  TextEditingController searchTextController = TextEditingController(text: "");

  ScrollController scrollController = ScrollController();

  List<DocumentEntity> documentList = [];
  MetaEntity? meta;

  bool loading = false;

  int pageNum = 1;
  int pageSize = 5;

  @override
  void onInit() {
    scrollController.addListener(scrollListener);
  }

  scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
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

    try {
      if (isInitialSearch) {
        documentList.clear();
        pageNum = 1;
      } else if (meta?.is_end ?? true) {
        /// 마지막 페이지에 도달했으면 더 이상 데이터를 불러오지 않음
        return;
      } else {
        /// 더 보기 요청 시 페이지 번호 증가
        pageNum++;
      }

      loading = true;
      update();


      DocumentsResponse documentsResponse = await HttpService.fetchImages(
          searchText: searchTextController.text, page: pageNum, size: pageSize);

      meta = documentsResponse.meta;

      if (isInitialSearch) {
        documentList = documentsResponse.documents;
      } else {
        documentList.addAll(documentsResponse.documents);
      }

      updateFavorite();
    } catch(e) {
      throw "Search 실패, error: $e";
    } finally {
      loading = false;
      update();
    }


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


    /// Favorite Page 에서 즐겨찾기 추가
    FavoriteController favoriteController = Get.find<FavoriteController>();
    if (isFavorite == true) {
      favoriteController.favoriteDocs.insert(0, document.copyWith());
    } else {
      favoriteController.favoriteDocs
          .removeWhere((element) => element.image_url == document.image_url);
    }
    favoriteController.update();


    update();
  }

}
