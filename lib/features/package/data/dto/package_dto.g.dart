// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageDto _$PackageDtoFromJson(Map<String, dynamic> json) => PackageDto(
      id: json['id'] as String,
      version: json['version'] as String,
      description: json['description'] as String?,
      iconUrl: json['iconUrl'] as String?,
      authors:
          (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      versions: (json['versions'] as List<dynamic>?)
          ?.map((e) => PackageVersionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PackageDtoToJson(PackageDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'description': instance.description,
      'iconUrl': instance.iconUrl,
      'authors': instance.authors,
      'tags': instance.tags,
      'versions': instance.versions,
    };
