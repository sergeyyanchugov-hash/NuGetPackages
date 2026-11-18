import '../../domain/package_model.dart';
import '../dto/package_dto.dart';
import '../dto/package_version_dto.dart';

extension PackageDtoMapper on PackageDto {
  PackageModel toDomain() {
    return PackageModel(
      id: id,
      version: version,
      description: description,
      iconUrl: iconUrl,
      versions: versions?.map((v) => v.toDomain()).toList() ?? [],
      dependencies: tags ?? [],
    );
  }
}

extension PackageVersionDtoMapper on PackageVersionDto {
  PackageVersionModel toDomain() {
    return PackageVersionModel(version: version);
  }
}
