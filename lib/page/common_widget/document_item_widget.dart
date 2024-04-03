import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/entity/document_entity.dart';

class DocumentItemWidget extends StatelessWidget {
  final DocumentEntity document;
  final Function() pictureTap;
  final Function() favTap;

  const DocumentItemWidget({
    super.key,
    required this.document,
    required this.pictureTap,
    required this.favTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildImage(context),
        const SizedBox(height: 6),
        _buildInfoRow(context),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    return InkWell(
      onTap: pictureTap,// _handleTap(context),
      child: CachedNetworkImage(
        width: double.infinity,
        fit: BoxFit.fitWidth,
        imageUrl: document.image_url,
        placeholder: (context, url) => _buildSubtlePlaceholder(),
        errorWidget: (context, url, error) => _buildImageErrorWidget(),
      ),
    );
  }

  Widget _buildSubtlePlaceholder() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.black.withOpacity(0.02), // 가벼운 회색 배경으로 미묘한 플레이스홀더 제공
    );
  }

  Widget _buildImageErrorWidget() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey[200],
      child: Icon(
        Icons.image_not_supported,
        size: 24,
        color: Colors.grey[500],
      ),
    );
  }


  Widget _buildInfoRow(BuildContext context) {
    return Row(
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
          onTap: favTap,
          child: document.isFavorite
              ? const Icon(Icons.star)
              : const Icon(Icons.star_border),
        ),
      ],
    );
  }

}
