class PackageVersionDto {
  final String version;
  PackageVersionDto({required this.version});
}

class PackageDto {
  final String id;
  final String version;
  final String? description;
  final String? iconUrl;
  final List<PackageVersionDto> versions;
  final List<String> dependencies;

  PackageDto({
    required this.id,
    required this.version,
    this.description,
    this.iconUrl,
    this.versions = const [],
    this.dependencies = const [],
  });
}
