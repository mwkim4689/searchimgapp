import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/entity/document_entity.dart';

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

/// preferences에 favoriteDocs 값을 저장
Future<void> setFavDocsToPrefs(List<DocumentEntity> favoriteDocs) async {
  String favoriteDocsStr = jsonEncode(favoriteDocs);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("favorite_docs", favoriteDocsStr);
}
