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
        if (_.loading == true) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            body: Padding(
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
          );
        }
      }),
    );
  }

  Widget documentItem(FavoriteController _, int index) {
    DocumentEntity document = _.favoriteDocs[index];

    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(DocumentDetailPage(document: document));
          },
          child: Image.network(document.image_url),
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
