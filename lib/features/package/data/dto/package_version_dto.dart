import 'package:json_annotation/json_annotation.dart';

part 'package_version_dto.g.dart';

@JsonSerializable()
class PackageVersionDto {
  final String version;

  PackageVersionDto({required this.version});

  factory PackageVersionDto.fromJson(Map<String, dynamic> json) => _$PackageVersionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PackageVersionDtoToJson(this);
}
