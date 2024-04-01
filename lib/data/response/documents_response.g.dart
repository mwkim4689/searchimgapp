// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentsResponse _$DocumentsResponseFromJson(Map<String, dynamic> json) =>
    DocumentsResponse(
      meta: MetaEntity.fromJson(json['meta'] as Map<String, dynamic>),
      documents: (json['documents'] as List<dynamic>)
          .map((e) => DocumentEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DocumentsResponseToJson(DocumentsResponse instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'documents': instance.documents,
    };
