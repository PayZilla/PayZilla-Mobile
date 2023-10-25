import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/functional_utils/log_util.dart';

abstract class IAuthRemoteDataSource {
  Future<UserAuthModel> login(AuthParams params);
  Future<bool> forgotPasswordInit(AuthParams params);
  Future<bool> forgotPasswordReset(AuthParams params);
  Future<User> getUser();
  Future<List<dynamic>> getKyc();
  Future<UserAuthModel> signUp(AuthParams params);
  Future<List<ReasonsModel>> fetchReasons();
  Future<String> emailVerificationInitiate();
  Future<String> tokenVerification(AuthParams params, {required String path});
  Future<bool> initializeBvn(AuthParams params);
  Future<bool> updateBvn(AuthParams params);
  Future<User> purpose(List<String> purpose);
  Future<bool> setPin(String pin);
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  AuthRemoteDataSource(this.http);
  final HttpManager http;

  @override
  Future<UserAuthModel> login(AuthParams params) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          authEndpoints.login,
          params.toMap(),
        ),
      );
      if (response.isResultOk) {
        return UserAuthModel.fromMap(response.data);
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<User> getUser() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(userEndpoints.getUser),
      );
      if (response.isResultOk) {
        return User.fromMap(response.data);
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserAuthModel> signUp(AuthParams params) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          authEndpoints.signUp,
          params.toMap(),
        ),
      );
      if (response.isResultOk) {
        return UserAuthModel.fromMap(response.data);
      }

      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<ReasonsModel>> fetchReasons() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(''),
      );
      if (response.isResultOk) {
        return [];
      }

      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> emailVerificationInitiate() async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          authEndpoints.emailVerificationInitiate,
          {},
        ),
      );
      if (response.isResultOk) {
        return response.message;
      }

      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> tokenVerification(
    AuthParams params, {
    required String path,
  }) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          path,
          params.toMap(),
        ),
      );
      if (response.isResultOk) {
        return response.message;
      }

      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> initializeBvn(AuthParams params) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          authEndpoints.bvnInitialize,
          params.toMap(),
        ),
      );
      if (response.isResultOk) {
        return response.status;
      }

      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> updateBvn(AuthParams params) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          authEndpoints.bvnUpdate,
          params.toMap(),
        ),
      );
      if (response.isResultOk) {
        return response.status;
      }

      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List> getKyc() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(authEndpoints.getKyc),
      );
      if (response.isResultOk) {
        return response.data;
      }

      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<User> purpose(List<String> purpose) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          authEndpoints.submitPurpose,
          {'registration_purpose': purpose},
        ),
      );
      if (response.isResultOk) {
        return User.fromMap(response.data);
      }

      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> setPin(String pin) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          accountEndpoints.pinSetup,
          {'pin': pin},
        ),
      );
      Log().debug('The message returned', response.data);
      if (response.isResultOk) {
        return response.status;
      }

      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> forgotPasswordInit(AuthParams params) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          authEndpoints.forgotPasswordInitiated,
          params.toMap(),
        ),
      );
      if (response.isResultOk) {
        return response.status;
      }

      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> forgotPasswordReset(AuthParams params) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          authEndpoints.forgotPasswordReset,
          params.toMap(),
        ),
      );
      if (response.isResultOk) {
        return response.status;
      }

      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }
}
