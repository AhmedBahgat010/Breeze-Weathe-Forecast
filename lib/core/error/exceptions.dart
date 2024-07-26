class ServerException implements Exception {
  String? message;

  ServerException(this.message);
}

class CacheException implements Exception {}

class NetWorkException implements Exception {}

class LocationException implements Exception {}
