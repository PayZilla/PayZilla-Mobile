// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

abstract class AppException implements Exception {
  String get message;

  @override
  bool operator ==(Object other) {
    return other is AppException && message == other.message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() {
    return 'AppException: $message';
  }
}

abstract class ServerException implements AppException {
  @override
  String toString() {
    return '$runtimeType: $message';
  }
}

class TimeoutServerException extends ServerException {
  TimeoutServerException([this.msg = 'connection timeout']);
  final String msg;

  @override
  String get message => msg;
}

class UnexpectedServerException extends ServerException {
  UnexpectedServerException([this.msg = 'An unexpected error occurred']);
  final String msg;

  @override
  String get message => msg;
}

class UnknownServerException extends ServerException {
  @override
  String get message => 'An unknown error occurred';
}

class SessionExpiredServerException extends ServerException {
  @override
  String get message => 'Your session has expired';
}

class AppServerException extends ServerException {
  AppServerException([this.msg = 'An unexpected error occurred']);
  final String msg;

  @override
  String get message => msg;
}

class InvalidArgOrDataException extends AppException {
  InvalidArgOrDataException([this.msg = 'error in arguments or data']);
  final String msg;
  @override
  String get message => msg;
}

class CacheGetException extends AppException {
  CacheGetException();
  @override
  String get message => 'error retrieving data from cache';
}

class CachePutException extends AppException {
  CachePutException();
  @override
  String get message => 'error storing data to cache';
}
