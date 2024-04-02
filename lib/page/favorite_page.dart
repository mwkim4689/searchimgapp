import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/favorite_controller.dart';
import '../data/entity/document_entity.dart';
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.separated(
                      // controller: _.scrollController,
                      itemCount: _.favoriteDocs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return documentItem(_, index);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 20);
                      },
                    ))
                  ],
                ),
              ),
              if (_.loading == true)
                Positioned.fill(
                  child: Container(
                    color: Colors.white.withOpacity(0.2),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget documentItem(FavoriteController _, int index) {
    DocumentEntity document = _.favoriteDocs[index];

    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() =>DocumentDetailPage(document: document),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 500), // 애니메이션 지속 시간 설정
            );
          },
          child: CachedNetworkImage(
            imageUrl: document.image_url,
            errorWidget: (context, url, error) => Container(
                height: 100,
                width: double.infinity,
                color: Colors.black.withOpacity(0.05),
                child: const Icon(Icons.error)),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                document.display_sitename,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            InkWell(
              onTap: () {
                favoriteController.setFavorite(document: document);
              },
              child: document.isFavorite
                  ? const Icon(Icons.star)
                  : const Icon(Icons.star_border),
            )
          ],
        )
      ],
    );
  }
}
