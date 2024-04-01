import 'package:json_annotation/json_annotation.dart';

part 'meta_entity.g.dart';

@JsonSerializable()
class MetaEntity {
  int total_count;
  int pageable_count;
  bool is_end;

  MetaEntity({required this.total_count, required this.pageable_count, required this.is_end});

  factory MetaEntity.fromJson(Map<String, dynamic> json) => _$MetaEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MetaEntityToJson(this);

}