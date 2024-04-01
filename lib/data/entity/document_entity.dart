import 'package:json_annotation/json_annotation.dart';

part 'document_entity.g.dart';

@JsonSerializable()
class DocumentEntity {
  String collection;
  String thumbnail_url;
  String image_url;
  int width;
  int height;
  String display_sitename;
  String doc_url;
  String datetime;

  DocumentEntity({
    required this.collection,
    required this.thumbnail_url,
    required this.image_url,
    required this.width,
    required this.height,
    required this.display_sitename,
    required this.doc_url,
    required this.datetime,
  });

  factory DocumentEntity.fromJson(Map<String, dynamic> json) =>
      _$DocumentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentEntityToJson(this);
}
