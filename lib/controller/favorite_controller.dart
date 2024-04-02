import 'dart:convert';

import 'package:get/get.dart';
import 'package:searchimgapp/controller/home_controller.dart';
import 'package:searchimgapp/controller/prefs_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/entity/document_entity.dart';

class FavoriteController extends GetxController {

  List<DocumentEntity> favoriteDocs = [];

  bool loading = false;

  Future<void> fetchFavoriteDcosFromPrefs() async {

    try {
      loading = true;
      update();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? favoriteDocsStr = prefs.getString("favorite_docs");

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

  Future<void> setFavorite({required DocumentEntity document}) async {

    /// 로컬에 favorite document list 상태 업데이트
    await Get.find<PrefsController>().setPrefsFavorite(
        document: document, isFavorite: false);


    /// Favorite 페이지에서 즐겨찾기 아이템 제거
    favoriteDocs.remove(document);


    /// 홈페이지에서 즐찾기기 Off
    HomeController homeController = Get.find<HomeController>();
    DocumentEntity? doc = homeController.documentList
        .firstWhereOrNull((element) => element.image_url == document.image_url);
    doc?.isFavorite = false;


    homeController.update();

    update();
  }
}
