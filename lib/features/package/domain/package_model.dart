class PackageVersionModel {
  final String version;

  const PackageVersionModel({required this.version});
}

class PackageModel {
  final String id;
  final String version;
  final String? description;
  final String? iconUrl;
  final List<PackageVersionModel> versions;
  final List<String> dependencies;

  const PackageModel({
    required this.id,
    required this.version,
    this.description,
    this.iconUrl,
    this.versions = const [],
    this.dependencies = const [],
  });
}
