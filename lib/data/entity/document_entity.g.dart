// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentEntity _$DocumentEntityFromJson(Map<String, dynamic> json) =>
    DocumentEntity(
      collection: json['collection'] as String,
      thumbnail_url: json['thumbnail_url'] as String,
      image_url: json['image_url'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      display_sitename: json['display_sitename'] as String,
      doc_url: json['doc_url'] as String,
      datetime: json['datetime'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$DocumentEntityToJson(DocumentEntity instance) =>
    <String, dynamic>{
      'collection': instance.collection,
      'thumbnail_url': instance.thumbnail_url,
      'image_url': instance.image_url,
      'width': instance.width,
      'height': instance.height,
      'display_sitename': instance.display_sitename,
      'doc_url': instance.doc_url,
      'datetime': instance.datetime,
      'isFavorite': instance.isFavorite,
    };
