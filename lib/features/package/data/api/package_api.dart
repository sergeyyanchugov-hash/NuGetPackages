import 'package:dio/dio.dart';
import '../dto/package_response_dto.dart';

class PackageApi {
  final Dio _dio;

  PackageApi(this._dio);

  Future<PackageResponseDto> searchPackages({
    required String query,
    int skip = 0,
    int take = 20,
  }) async {
    final response = await _dio.get(
      '/query',
      queryParameters: {
        'q': query,
        'skip': skip,
        'take': take,
      },
    );
    return PackageResponseDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<PackageResponseDto> getPackageDetail(String id) async {
    final response = await _dio.get(
      '/query',
      queryParameters: {
        'q': 'packageid:${id.toLowerCase()}',
        'take': 1,
      },
    );
    return PackageResponseDto.fromJson(response.data as Map<String, dynamic>);
  }
}
