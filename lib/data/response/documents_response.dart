import 'package:json_annotation/json_annotation.dart';

import '../entity/document_entity.dart';
import '../entity/meta_entity.dart';

part 'documents_response.g.dart';

@JsonSerializable()
class DocumentsResponse {
  MetaEntity meta;
  List<DocumentEntity> documents;

  DocumentsResponse({required this.meta, required this.documents,});

  factory DocumentsResponse.fromJson(Map<String, dynamic> json) => _$DocumentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentsResponseToJson(this);

}