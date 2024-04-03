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
        errorWidget: (context, url, error) => _buildErrorWidget(),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      height: 100,
      width: double.infinity,
      color: Colors.black.withOpacity(0.05),
      child: const Icon(Icons.error),
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
