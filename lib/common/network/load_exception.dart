sealed class LoadException implements Exception {
  final String message;

  const LoadException(this.message);

  @override
  String toString() => message;
}

final class NetworkException extends LoadException {
  const NetworkException([super.message = 'Network error']);
}

final class ServerException extends LoadException {
  final int? statusCode;

  const ServerException(this.statusCode, [super.message = 'Server error']);
}

final class UnknownLoadException extends LoadException {
  const UnknownLoadException([super.message = 'Unknown error']);
}
