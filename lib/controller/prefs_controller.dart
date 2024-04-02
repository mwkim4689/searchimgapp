import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchimgapp/controller/favorite_controller.dart';
import 'package:searchimgapp/controller/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/entity/document_entity.dart';

class PrefsController extends GetxController {
  Future<void> setPrefsFavorite(
      {required DocumentEntity document, required bool isFavorite}) async {


    /// Prefrences의 즐겨찾기 값에 따른 리스트 추가 or 제거
    List<DocumentEntity> favoriteDocs = await getFavoriteDocsFromPrefs();

    if (isFavorite == true) {
      // favoriteDocs.add(document);
      favoriteDocs.add(document.copyWith());
    } else {
      // favoriteDocs.remove(document);
      favoriteDocs.removeWhere((element) => element.image_url == document.image_url);
    }


    /// Preferences에 favorite list 상태 저장
    String favoriteDocsStr = jsonEncode(favoriteDocs);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("favorite_docs", favoriteDocsStr);

    update();
  }

  /// preferences에서 favoriteDocs를 가져옴
  Future<List<DocumentEntity>> getFavoriteDocsFromPrefs() async {
    List<DocumentEntity> favoriteDocs = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favoriteDocsStr = prefs.getString("favorite_docs");

    if (favoriteDocsStr != null) {
      List<dynamic> favoriteDocsMapList = jsonDecode(favoriteDocsStr);

      favoriteDocs = favoriteDocsMapList.map((e) {
        return DocumentEntity.fromJson(e as Map<String, dynamic>);
      }).toList();
    }

    return favoriteDocs;
  }
}