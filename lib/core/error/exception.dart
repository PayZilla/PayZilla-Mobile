// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

abstract class PZillaException implements Exception {
  String get message;

  @override
  bool operator ==(Object other) {
    return other is PZillaException && message == other.message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() {
    return 'PZillaichangeException: $message';
  }
}

abstract class ServerException implements PZillaException {
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

class PZillaServerException extends ServerException {
  PZillaServerException([this.msg = 'An unexpected error occurred']);
  final String msg;

  @override
  String get message => msg;
}

class InvalidArgOrDataException extends PZillaException {
  InvalidArgOrDataException([this.msg = 'error in arguments or data']);
  final String msg;
  @override
  String get message => msg;
}

class CacheGetException extends PZillaException {
  CacheGetException();
  @override
  String get message => 'error retrieving data from cache';
}

class CachePutException extends PZillaException {
  CachePutException();
  @override
  String get message => 'error storing data to cache';
}
