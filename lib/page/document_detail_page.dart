
import 'package:flutter/material.dart';
import 'package:searchimgapp/data/entity/document_entity.dart';

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
      body: SafeArea(
        child: Center(
          child: Image.network(widget.document.image_url),

        ),
      ),
    );
  }
}
