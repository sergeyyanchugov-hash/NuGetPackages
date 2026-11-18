import 'package:dio/dio.dart';
import 'package:nuget_packages/common/network/load_exception.dart';
import '../api/package_api.dart';
import '../dto/package_response_dto.dart';
import 'i_package_data_source.dart';

class NetworkPackageDataSource implements IPackageDataSource {
  final PackageApi _api;

  NetworkPackageDataSource(this._api);

  @override
  Future<PackageResponseDto> searchPackages({
    required String query,
    int skip = 0,
    int take = 20,
  }) async {
    try {
      return await _api.searchPackages(query: query, skip: skip, take: take);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw const NetworkException('network_error');
      }
      throw ServerException(e.response?.statusCode, e.message ?? 'Server error');
    } catch (e) {
      throw UnknownLoadException(e.toString());
    }
  }

  @override
  Future<PackageResponseDto> getPackageDetail(String id) async {
    try {
      return await _api.getPackageDetail(id);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw const NetworkException('network_error');
      }
      throw ServerException(e.response?.statusCode, e.message ?? 'Server error');
    } catch (e) {
      throw UnknownLoadException(e.toString());
    }
  }
}
