import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/entity/document_entity.dart';

class PrefsController extends GetxController {
  Future<void> setPrefsFavorite(
      {required DocumentEntity document, required bool isFavorite}) async {


    /// Prefrences에 favoriteDoc 리스트 추가/제거
    List<DocumentEntity> favoriteDocs = await getFavoriteDocsFromPrefs();

    if (isFavorite == true) {
      favoriteDocs.insert(0,document.copyWith());
    } else {
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
