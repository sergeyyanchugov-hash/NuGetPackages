import 'package:json_annotation/json_annotation.dart';
import 'package_version_dto.dart';

part 'package_dto.g.dart';

@JsonSerializable()
class PackageDto {
  final String id;
  final String version;
  final String? description;
  final String? iconUrl;
  final List<String>? authors;
  final List<String>? tags;
  final List<PackageVersionDto>? versions;

  PackageDto({
    required this.id,
    required this.version,
    this.description,
    this.iconUrl,
    this.authors,
    this.tags,
    this.versions,
  });

  factory PackageDto.fromJson(Map<String, dynamic> json) => _$PackageDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PackageDtoToJson(this);
}
