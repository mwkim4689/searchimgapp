import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchimgapp/controller/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/entity/document_entity.dart';
import 'common_method/prefs.dart';

class FavoriteController extends GetxController {

  List<DocumentEntity> favoriteDocs = [];

  bool loading = false;

  ///로컬에서 즐겨찾기 값 가져와서 업데이트
  Future<void> fetchFavoriteDcosFromPrefs() async {

    try {
      loading = true;
      update();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? favoriteDocsStr = prefs.getString("favorite_docs");

      debugPrint("favoriteDocsStr : ${favoriteDocsStr}");

      if (favoriteDocsStr != null) {
        List<dynamic> favoriteDocsMapList = jsonDecode(favoriteDocsStr);


        favoriteDocs = favoriteDocsMapList.map((e) {
          return DocumentEntity.fromJson(e as Map<String, dynamic>);
        }).toList();
      }
    } catch(e) {
      throw "SharedPreferences, favorite_docs Error : $e ";
    } finally {
      loading = false;
      update();
    }




  }


  ///즐겨찾기 값 업데이트 - (1) Favorite Page (2) 로컬 저장 (3) Home Page
  Future<void> setFavoriteVer2(
      {required DocumentEntity document, required bool isFavorite}) async {

    // Favorite Page 에서 즐겨찾기 추가하거나 제거
    document.isFavorite = isFavorite;
    if (isFavorite == true) {
      favoriteDocs.insert(0, document.copyWith());
    } else {
      favoriteDocs
          .removeWhere((element) => element.image_url == document.image_url);
    }

    // Preferences에 favorite list 상태 저장
    await setFavDocsToPrefs(favoriteDocs);

    // HomePage에서 documentList에 즐겨찾기 값 업데이트
    Get.find<HomeController>().updateFavorite();

    update();


  }



}
