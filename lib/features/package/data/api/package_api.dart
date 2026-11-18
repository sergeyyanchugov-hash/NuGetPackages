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
    final formattedQuery = query.trim().isEmpty ? '' : 'id:${query.trim()}';
    final response = await _dio.get(
      '/query',
      queryParameters: {
        'q': formattedQuery,
        'skip': skip,
        'take': take,
      },
    );
    return PackageResponseDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<PackageResponseDto> getPackageDetail(String id) async {
    // 1. Сначала пробуем точный поиск по packageid
    var response = await _dio.get(
      '/query',
      queryParameters: {
        'q': 'packageid:${id.toLowerCase()}',
        'take': 1,
      },
    );
    var dto = PackageResponseDto.fromJson(response.data as Map<String, dynamic>);
    if (dto.data.isNotEmpty) {
      return dto;
    }

    // 2. Если по packageid ничего не найдено, ищем по id:...
    response = await _dio.get(
      '/query',
      queryParameters: {
        'q': 'id:${id.toLowerCase()}',
        'take': 1,
      },
    );
    dto = PackageResponseDto.fromJson(response.data as Map<String, dynamic>);
    if (dto.data.isNotEmpty) {
      return dto;
    }

    // 3. Общий поиск по ключевому слову/тегу
    response = await _dio.get(
      '/query',
      queryParameters: {
        'q': id,
        'take': 1,
      },
    );
    return PackageResponseDto.fromJson(response.data as Map<String, dynamic>);
  }
}
