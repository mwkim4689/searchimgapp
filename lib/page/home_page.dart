import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:searchimgapp/controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeController homeController = Get.put(HomeController());

  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                      controller: _textEditingController,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (String text) {
                        homeController.search(text);
                      },
                      onChanged: (String text) {
                        homeController.setSearchText(text);
                      },
                      decoration: const InputDecoration(
                        hintText: "검색어를 입력하세요",
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
                        _textEditingController.text = '';
                        // appController.clearSearchRecords();
                      },
                      child: const Icon(Icons.close, size: 20),

                    ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
