import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchimgapp/controller/favorite_controller.dart';
import 'package:searchimgapp/controller/home_controller.dart';
import 'package:searchimgapp/page/common_widget/loading_indicator_widget.dart';

import '../data/entity/document_entity.dart';
import '../util/enums.dart';
import 'common_widget/document_item_widget.dart';
import 'document_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.find();

  final ScrollController _scrollController = ScrollController();
  final FocusNode _searchFieldFocusNode = FocusNode(); // FocusNode 객체 추가

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    _searchFieldFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  scrollListener() async {
    /// 스크롤 맨 아래로 갔을 때, search를 호출해서 페이징 되도록 함
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      SearchResult result = SearchResult.fail;
      result = await homeController.search(isInitialSearch: false);
      showSearchFailSnackBar(result, context);
    }
  }

  /// 포커스 해제하여 키보드를 숨김.
  void _onTapOutside() {
    _searchFieldFocusNode.unfocus(); // 포커스 해제
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
                _buildMainContent(context, _),
                if (_.loading == true) const LoadingIndicatorWidget()
                //_buildLoadingIndicator(),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, HomeController _) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
      child: Column(
        children: [
          _buildSearchBar(context),
          const SizedBox(height: 6),
          _buildSearchResults(_)
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.black.withOpacity(0.05),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: homeController.searchTextController,
              textInputAction: TextInputAction.search,
              focusNode: _searchFieldFocusNode,
              onFieldSubmitted: (String text) async {
                SearchResult result = SearchResult.fail;
                result = await homeController.search(isInitialSearch: true);
                showSearchFailSnackBar(result, context);
              },
              decoration: InputDecoration(
                hintText: "검색어를 입력하세요",
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.35)),
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
    );
  }

  Widget _buildSearchResults(HomeController _) {
    return Expanded(
      child: ListView.separated(
        controller: _scrollController,
        itemCount: _.documentList.length,
        itemBuilder: (BuildContext context, int index) {
          DocumentEntity document = _.documentList[index];
          return DocumentItemWidget(
            document: document,
            pictureTap: () {
              if (_searchFieldFocusNode.hasFocus) {
                _searchFieldFocusNode.unfocus();
              } else {
                Get.to(() => DocumentDetailPage(document: document),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 500));
              }
            },
            favTap: () {
              Get.find<FavoriteController>().setFavorite(
                document: document,
                isFavorite: !(document.isFavorite),
              );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 20);
        },
      ),
    );
  }

  void showSearchFailSnackBar(SearchResult result, BuildContext context) {
    if (result == SearchResult.fail) {
      if (context.mounted == true) {
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
