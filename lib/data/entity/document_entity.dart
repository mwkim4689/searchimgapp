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

  DocumentEntity copyWith({
    String? collection,
    String? thumbnail_url,
    String? image_url,
    int? width,
    int? height,
    String? display_sitename,
    String? doc_url,
    String? datetime,
    bool? isFavorite
  }) {
    return DocumentEntity(
      collection: collection ?? this.collection,
      thumbnail_url: thumbnail_url ?? this.thumbnail_url,
      image_url: image_url ?? this.image_url,
      width: width ?? this.width,
      height: height ?? this.height,
      display_sitename: display_sitename ?? this.display_sitename,
      doc_url: doc_url ?? this.doc_url,
      datetime: datetime ?? this.datetime,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
