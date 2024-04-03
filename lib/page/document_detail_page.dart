import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:searchimgapp/data/entity/document_entity.dart';

import '../util/app_utils.dart';

class DocumentDetailPage extends StatefulWidget {
  final DocumentEntity document;

  const DocumentDetailPage({super.key, required this.document});

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
              width: double.infinity,
              fit: BoxFit.fitWidth,
              imageUrl: widget.document.image_url,
              errorWidget: (context, url, error) => _buildImageErrorWidget(),
            ),
          ),
          SizedBox(height: AppUtils.get2BarHeight(context)),
        ],
      ),
    );
  }

  Widget _buildImageErrorWidget() {
    return Container(
      width: double.infinity,
      color: Colors.grey[200],
      child: Icon(
        Icons.image_not_supported,
        size: 24,
        color: Colors.grey[500],
      ),
    );
  }

}
