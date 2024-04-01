// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentsResponse _$DocumentsResponseFromJson(Map<String, dynamic> json) =>
    DocumentsResponse(
      metaEntity:
          MetaEntity.fromJson(json['metaEntity'] as Map<String, dynamic>),
      documents: (json['documents'] as List<dynamic>)
          .map((e) => DocumentEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DocumentsResponseToJson(DocumentsResponse instance) =>
    <String, dynamic>{
      'metaEntity': instance.metaEntity,
      'documents': instance.documents,
    };
