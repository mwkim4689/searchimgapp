import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:searchimgapp/controller/home_controller.dart';
import 'package:searchimgapp/page/document_detail_page.dart';

import '../data/entity/document_entity.dart';
import '../util/enums.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.find();

  ScrollController scrollController = ScrollController();
  FocusNode searchFieldFocusNode = FocusNode(); // FocusNode 객체 추가

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);

  }


  @override
  void dispose() {
    searchFieldFocusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }

  scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      SearchResult result = SearchResult.fail;
      result = await homeController.search(isInitialSearch: false);
      if(result == SearchResult.fail) {
        if(context.mounted == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("검색이 실패했습니다."),
              duration: Duration(seconds: 3), // 스낵바 표시 시간 설정
            ),
          );
        }
      }
    }
  }

  /// 포커스 해제하여 키보드를 숨깁니다.
  void _onTapOutside() {
    searchFieldFocusNode.unfocus(); // 포커스 해제
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapOutside,
      child: SafeArea(
        child: Scaffold(
          body: GetBuilder<HomeController>(builder: (_) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.black.withOpacity(0.05),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: homeController.searchTextController,
                                textInputAction: TextInputAction.search,
                                focusNode: searchFieldFocusNode,
                                onFieldSubmitted: (String text) async{

                                  SearchResult result = SearchResult.fail;
                                  result = await homeController.search(isInitialSearch: true);
                                  if (result == SearchResult.fail) {
                                    if (context.mounted == true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("검색이 실패했습니다."),
                                          duration: Duration(
                                              seconds: 3), // 스낵바 표시 시간 설정
                                        ),
                                      );
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "검색어를 입력하세요",
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.35)),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            // if (_.searchRecords.isNotEmpty || _.searchText.isNotEmpty)
                            InkWell(
                              onTap: () {
                                homeController.clearSearchText();
                              },
                              child: const Icon(Icons.close, size: 20),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: ListView.separated(
                          controller: scrollController,
                          itemCount: _.documentList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return documentItem(_, index, context);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 20);
                          },
                        ),
                      )
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
            );
          }),
        ),
      ),
    );
  }

  Widget documentItem(HomeController _, int index, BuildContext context) {
    DocumentEntity document = _.documentList[index];

    return Column(
      children: [
        InkWell(
          onTap: () async{
            if(searchFieldFocusNode.hasFocus) {
              searchFieldFocusNode.unfocus();
            }else {
              Get.to(() =>DocumentDetailPage(document: document),
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 500), // 애니메이션 지속 시간 설정
              );
            }

          },
          child: CachedNetworkImage(
            width: Get.width,
            fit: BoxFit.fitWidth,
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
                homeController.setFavorite(
                    document: document, isFavorite: !(document.isFavorite));
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
