import 'package:json_annotation/json_annotation.dart';

part 'document_entity.g.dart';

@JsonSerializable()
class DocumentEntity {
  final String collection;
  final String thumbnail_url;
  final String image_url;
  final int width;
  final int height;
  final String display_sitename;
  final String doc_url;
  final String datetime;
  bool isFavorite;

  DocumentEntity({
    required this.collection,
    required this.thumbnail_url,
    required this.image_url,
    required this.width,
    required this.height,
    required this.display_sitename,
    required this.doc_url,
    required this.datetime,
    this.isFavorite = false,
  });

  factory DocumentEntity.fromJson(Map<String, dynamic> json) =>
      _$DocumentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentEntityToJson(this);
}
