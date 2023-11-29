abstract class Failure {
  String get message;
  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    return other is Failure && message == other.message;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => message.hashCode;
}

class ApiFailure extends Failure {
  ApiFailure({this.msg = ''});

  final String msg;
  @override
  String get message => msg;
}

class NetworkFailure extends Failure {
  @override
  String get message => 'Network unavailable';
}

class ServerFailure extends Failure {
  ServerFailure([this.msg = '']);
  final String msg;
  @override
  String get message => msg;
}

class SessionFailure extends Failure {
  SessionFailure([this.msg = '']);
  final String msg;
  @override
  String get message => msg;
}

class UnexpectedFailure extends Failure {
  @override
  String get message => 'Unexpected error occurred';
}

class InvalidArgOrDataFailure extends Failure {
  InvalidArgOrDataFailure([this.msg = 'Some fields are invalid']);
  final String msg;
  @override
  String get message => msg;
}

class LocalAuthFailure extends Failure {
  @override
  String get message => 'Biometric authentication failed';
}
