import 'package:json_annotation/json_annotation.dart';
import 'package_dto.dart';

part 'package_response_dto.g.dart';

@JsonSerializable()
class PackageResponseDto {
  final int totalHits;
  final List<PackageDto> data;

  PackageResponseDto({
    required this.totalHits,
    required this.data,
  });

  factory PackageResponseDto.fromJson(Map<String, dynamic> json) => _$PackageResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PackageResponseDtoToJson(this);
}
