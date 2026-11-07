import 'package:nuget_packages/features/package/domain/package_model.dart';

abstract class IPackageRepository {
  Future<List<PackageModel>> getPackages(String query);
  Future<PackageModel?> getPackageDetail(String id);
}
