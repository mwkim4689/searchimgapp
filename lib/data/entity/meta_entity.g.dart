// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaEntity _$MetaEntityFromJson(Map<String, dynamic> json) => MetaEntity(
      total_count: json['total_count'] as int,
      pageable_count: json['pageable_count'] as int,
      is_end: json['is_end'] as bool,
    );

Map<String, dynamic> _$MetaEntityToJson(MetaEntity instance) =>
    <String, dynamic>{
      'total_count': instance.total_count,
      'pageable_count': instance.pageable_count,
      'is_end': instance.is_end,
    };
