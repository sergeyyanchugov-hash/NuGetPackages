import 'package_model.dart';

abstract class IPackageRepository {
  Future<List<PackageModel>> getPackages(String query, {int skip = 0, int take = 20});
  Future<PackageModel?> getPackageDetail(String id);
}
