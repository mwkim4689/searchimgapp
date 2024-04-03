import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/favorite_controller.dart';
import '../data/entity/document_entity.dart';
import 'common_widget/document_item_widget.dart';
import 'common_widget/loading_indicator_widget.dart';
import 'document_detail_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  FavoriteController favoriteController = Get.find();

  @override
  void initState() {
    super.initState();

    favoriteController.fetchFavoriteDcosFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<FavoriteController>(builder: (_) {
        return Scaffold(
          body: Stack(
            children: [
              _buildMainContent(_),
              if (_.loading == true) const LoadingIndicatorWidget(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildMainContent(FavoriteController _) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Expanded(
              child: ListView.separated(
            itemCount: _.favoriteDocs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentEntity document = _.favoriteDocs[index];
              return DocumentItemWidget(
                document: document,
                pictureTap: (){
                  Get.to(() => DocumentDetailPage(document: document),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 500));
                },
                favTap: () {
                  favoriteController.setFavorite(document: document);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20);
            },
          )),
        ],
      ),
    );
  }
}
