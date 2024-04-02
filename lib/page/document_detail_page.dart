import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchimgapp/data/entity/document_entity.dart';

import '../util/app_utils.dart';

class DocumentDetailPage extends StatefulWidget {
  DocumentEntity document;

  DocumentDetailPage({super.key, required this.document});

  @override
  State<DocumentDetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DocumentDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.document.display_sitename),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CachedNetworkImage(
              width: Get.width,
              fit: BoxFit.fitWidth,
              imageUrl: widget.document.image_url,
              errorWidget: (context, url, error) => Container(
                  height: 400,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.05),
                  child: const Icon(Icons.error)),
            ),
          ),
          SizedBox(height: AppUtils.get2BarHeight(context)),
        ],
      ),
    );
  }

}
