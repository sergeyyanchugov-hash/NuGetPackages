import '../domain/i_package_repository.dart';
import '../domain/package_model.dart';
import 'data_sources/i_package_data_source.dart';
import 'mappers/package_mapper.dart';

class PackageRepository implements IPackageRepository {
  final IPackageDataSource _dataSource;

  PackageRepository(this._dataSource);

  @override
  Future<List<PackageModel>> getPackages(String query) async {
    final response = await _dataSource.searchPackages(query: query);
    return response.data.map((dto) => dto.toDomain()).toList();
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
