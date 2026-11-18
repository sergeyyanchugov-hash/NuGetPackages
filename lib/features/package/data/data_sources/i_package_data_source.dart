import '../dto/package_response_dto.dart';

abstract class IPackageDataSource {
  Future<PackageResponseDto> searchPackages({
    required String query,
    int skip = 0,
    int take = 20,
  });

  Future<PackageResponseDto> getPackageDetail(String id);
}
