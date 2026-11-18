// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageResponseDto _$PackageResponseDtoFromJson(Map<String, dynamic> json) =>
    PackageResponseDto(
      totalHits: (json['totalHits'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => PackageDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PackageResponseDtoToJson(PackageResponseDto instance) =>
    <String, dynamic>{
      'totalHits': instance.totalHits,
      'data': instance.data,
    };
