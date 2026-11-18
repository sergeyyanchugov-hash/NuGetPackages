import '../domain/i_package_repository.dart';
import '../domain/package_model.dart';
import 'data_sources/i_package_data_source.dart';
import 'mappers/package_mapper.dart';

class PackageRepository implements IPackageRepository {
  final IPackageDataSource _dataSource;

  PackageRepository(this._dataSource);

  @override
  Future<List<PackageModel>> getPackages(String query, {int skip = 0, int take = 20}) async {
    final response = await _dataSource.searchPackages(query: query, skip: skip, take: take);
    final packages = response.data.map((dto) => dto.toDomain()).toList();
    final trimmed = query.trim().toLowerCase();
    if (trimmed.isEmpty) {
      return packages;
    }
    // Фильтруем результаты строго по названию/ID пакета, исключая совпадения только в описании
    return packages.where((pkg) => pkg.id.toLowerCase().contains(trimmed)).toList();
  }

  @override
  Future<PackageModel?> getPackageDetail(String id) async {
    final response = await _dataSource.getPackageDetail(id);
    if (response.data.isEmpty) {
      return null;
    }
    return response.data.first.toDomain();
  }
}
