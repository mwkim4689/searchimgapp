
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchimgapp/controller/home_controller.dart';

import '../data/entity/document_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());



  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text("이미지 검색 페이지"),
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 6,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: homeController.searchTextController,
                        textInputAction: TextInputAction.search,
                        onFieldSubmitted: (String text) {
                          homeController.search();
                        },
                        onChanged: (String text) {
                          homeController.setSearchText(text);
                        },
                        decoration: const InputDecoration(
                          hintText: "검색어를 입력하세요",
                          // border: InputBorder.none,
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          // errorBorder: InputBorder.none,
                          // disabledBorder: InputBorder.none,
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
              Expanded(
                child: GetBuilder<HomeController>(
                  builder: (_) {
                    debugPrint("Listview.separated before");
                    return ListView.separated(
                      controller: _.scrollController,
                      itemCount: _.documentList.length,
                      itemBuilder: (BuildContext context, int index){
                        return documentItem(_, index);
                      },
                      separatorBuilder: (BuildContext context, int index){
                        return const SizedBox(height: 20);
                      },
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget documentItem(HomeController _, int index) {

    DocumentEntity document = _.documentList[index];

    return Container(
      child: Column(
        children: [
          Image.network(document.image_url),
          Text(document.display_sitename)
        ],
      ),
    );

  }
}
