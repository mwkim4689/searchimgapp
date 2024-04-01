import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:searchimgapp/data/response/documents_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    DocumentsResponse documentsResponse =
    await HttpService.fetchImages(searchText: searchTextController.text, page: pageNum, size: pageSize);

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

    List<DocumentEntity> favoriteDocs = await getFavoriteDocsFromPrefs();

    for(DocumentEntity doc in documentList) {
      for(DocumentEntity favDoc in favoriteDocs) {
        if(doc.image_url == favDoc.image_url) {
          doc.isFavorite = true;
        }
      }

    }

  }



  Future<void> setFavorite({required DocumentEntity document}) async {
    document.isFavorite ^= true;

    List<DocumentEntity> favoriteDocs = await getFavoriteDocsFromPrefs();


    if(document.isFavorite == true) {
      favoriteDocs.add(document);
    } else {
      favoriteDocs.remove(document);
    }

    if(favoriteDocs.isNotEmpty) {

      String favoriteDocsStr = jsonEncode(favoriteDocs);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("favorite_docs", favoriteDocsStr);
    }




    debugPrint("favoriteDocs, ${favoriteDocs.first.isFavorite}");
    // debugPrint("favoriteDocsVar, ${favoriteDocsVar.toString()}");
    debugPrint("favoriteDocs, ${favoriteDocs.runtimeType}");


    update();

  }

  Future<List<DocumentEntity>> getFavoriteDocsFromPrefs() async {
    List<DocumentEntity> favoriteDocs = [];


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favoriteDocsStr = prefs.getString("favorite_docs");

    if(favoriteDocsStr != null) {

      List<dynamic> favoriteDocsMapList = jsonDecode(favoriteDocsStr);

      favoriteDocs = favoriteDocsMapList.map((e) {
        return DocumentEntity.fromJson(e as Map<String, dynamic>);
      }).toList();

    }

    return favoriteDocs;
  }
}
