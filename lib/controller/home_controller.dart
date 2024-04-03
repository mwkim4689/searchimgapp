import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:searchimgapp/data/response/documents_response.dart';

import '../data/entity/document_entity.dart';
import '../data/entity/meta_entity.dart';
import '../service/http_service.dart';
import '../util/enums.dart';
import 'common_method/prefs.dart';

class HomeController extends GetxController {
  TextEditingController searchTextController = TextEditingController(text: "");

  List<DocumentEntity> documentList = [];
  MetaEntity? meta;

  bool loading = false;
  /// 페이지 번호
  int pageNum = 1;
  /// 한 번 검색시 나오는 문서 수
  int pageSize = 5;


  void setSearchText(String text) {
    searchTextController.text = text;
    update();
  }

  void clearSearchText() {
    searchTextController.text = "";
    update();
  }


  /// 검색을 수행합니다.
  /// [isInitialSearch]가 true일 경우, 새로운 검색을 시작하고 기존 결과를 지웁니다.
  /// 검색 성공 시 SearchResult.success를 반환하고,
  /// 실패하거나 데이터가 없을 경우 해당 결과를 반환합니다.
  Future<SearchResult> search({bool isInitialSearch = false}) async {
    final searchStatus = canSearch(isInitialSearch);
    if (searchStatus != SearchResult.success) return searchStatus;

    try {
      loading = true;
      update();
      DocumentsResponse documentsResponse = await HttpService.fetchImages(
          searchText: searchTextController.text, page: pageNum, size: pageSize);

      handleSearchResults(documentsResponse, isInitialSearch);
      await updateFavorite();

      return SearchResult.success;
    } catch (e) {
      return SearchResult.fail;
    } finally {
      loading = false;
      update();
    }
  }


  SearchResult canSearch(bool isInitialSearch) {
    // 초기 검색의 경우, 이전 결과를 지우고 새로 시작
    if (isInitialSearch) {
      documentList.clear();
      pageNum = 1;
      return SearchResult.success;
    }

    // meta 정보가 없는 경우, 실패로 처리
    if (meta == null) {
      return SearchResult.fail;
    }
    // 더 이상 불러올 데이터가 없는 경우
    else if (meta?.is_end ?? true) {
      return SearchResult.noData;
    }

    // 다음 페이지로 넘어갈 준비
    pageNum++;
    return SearchResult.success;
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
    List<DocumentEntity> favoriteDocs = await getFavoriteDocsFromPrefs();

    //isFavorite false로 초기화 - 즐겨찾기 페이지에서 삭제했을 때 홈페이지에서도 즐겨찾기 삭제
    for (DocumentEntity doc in documentList) {
      doc.isFavorite = false;
    }

    //즐겨찾기 리스트에 저장된 값에 따라 검색 페이지의 이미지 리스트에 즐겨찾기 값 업데이트
    for (DocumentEntity favDoc in favoriteDocs) {
      for (DocumentEntity doc in documentList) {
        if (doc.image_url == favDoc.image_url) {
          doc.isFavorite = true;
        }
      }
    }

    update();
  }


}
