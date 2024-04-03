import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:searchimgapp/controller/favorite_controller.dart';
import 'package:searchimgapp/controller/prefs_controller.dart';
import 'package:searchimgapp/data/response/documents_response.dart';

import '../data/entity/document_entity.dart';
import '../data/entity/meta_entity.dart';
import '../service/http_service.dart';
import '../util/enums.dart';

class HomeController extends GetxController {
  TextEditingController searchTextController = TextEditingController(text: "");

  List<DocumentEntity> documentList = [];
  MetaEntity? meta;

  bool loading = false;

  int pageNum = 1;
  int pageSize = 5;


  void setSearchText(String text) {
    searchTextController.text = text;
    update();
  }

  void clearSearchText() {
    searchTextController.text = "";
    update();
  }


  Future<SearchResult> search({bool isInitialSearch = false}) async {
    if (!canSearch(isInitialSearch)) return SearchResult.fail;

    try {
      loading = true;
      update();
      DocumentsResponse documentsResponse = await HttpService.fetchImages(
          searchText: searchTextController.text, page: pageNum, size: pageSize);

      handleSearchResults(documentsResponse, isInitialSearch);
      updateFavorite();
      return SearchResult.success;
    } catch (e) {
      return SearchResult.fail;
    } finally {
      loading = false;
      update();
    }
  }

  bool canSearch(bool isInitialSearch) {
    if (isInitialSearch) {
      documentList.clear();
      pageNum = 1;
      return true;
    }

    if (meta?.is_end ?? true) return false;

    pageNum++;
    return true;
  }

  Future<DocumentsResponse?> fetchSearchResults(bool isInitialSearch) async {
    return await HttpService.fetchImages(
        searchText: searchTextController.text, page: pageNum, size: pageSize);
  }

  void handleSearchResults(DocumentsResponse response, bool isInitialSearch) {
    meta = response.meta;

    if (isInitialSearch) {
      documentList = response.documents;
    } else {
      documentList.addAll(response.documents);
    }
  }



  /// 검색한 후 리스팅 할 때, 즐겨찾기에 저장된 문서랑 같은게 있을 때, favorite 추가
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
