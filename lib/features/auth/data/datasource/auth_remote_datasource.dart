import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';

abstract class IAuthRemoteDataSource {
  Future<Either<Failure, User>> getUser();
  Future<Either<ApiFailure, User>> purpose(List<String> purpose);

  Future<Either<ApiFailure, UserAuthModel>> login(AuthParams params);
  Future<Either<ApiFailure, UserAuthModel>> signUp(AuthParams params);

  Future<Either<ApiFailure, List<ReasonsModel>>> fetchReasons();
  Future<Either<ApiFailure, List<dynamic>>> getKyc();
  Future<Either<ApiFailure, String>> emailVerificationInitiate();
  Future<Either<ApiFailure, String>> tokenVerification(AuthParams params);
  Future<Either<ApiFailure, String>> initializeBvn();
  Future<Either<ApiFailure, bool>> updateBvn(AuthParams params);
  Future<Either<ApiFailure, bool>> setPin(String pin);
  Future<Either<ApiFailure, bool>> forgotPasswordInit(AuthParams params);
  Future<Either<ApiFailure, bool>> forgotPasswordReset(AuthParams params);
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  AuthRemoteDataSource(this.http);
  final HttpManager http;

  @override
  Future<Either<ApiFailure, UserAuthModel>> login(AuthParams params) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          authEndpoints.login,
          params.toMap(),
        ),
      );

      return Right(UserAuthModel.fromMap(response.data));
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(userEndpoints.getUser),
      );

      return Right(User.fromMap(response.data));
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      if (err is SessionExpiredServerException) {
        return Left(SessionFailure(err.toString()));
      }
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, UserAuthModel>> signUp(AuthParams params) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          authEndpoints.signUp,
          params.toMap(),
        ),
      );

      return Right(UserAuthModel.fromMap(response.data));
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, List<ReasonsModel>>> fetchReasons() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(''),
      );

      return const Right([]);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, String>> emailVerificationInitiate() async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          authEndpoints.emailVerificationInitiate,
          {},
        ),
      );

      return Right(response.message);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, String>> tokenVerification(
    AuthParams params,
  ) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          params.tokenRoute,
          params.toMap(),
        ),
      );

      return Right(response.message);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, String>> initializeBvn() async {
    try {
      final response =
          await http.get(authEndpoints.bvnInitialize, version: Version.v2);

      return Right(response['url']);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, bool>> updateBvn(AuthParams params) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          authEndpoints.bvnUpdate,
          params.toMap(),
        ),
      );
      return Right(response.status);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, List<dynamic>>> getKyc() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(authEndpoints.getKyc),
      );

      return Right(response.data);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, User>> purpose(List<String> purpose) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          authEndpoints.submitPurpose,
          {'registration_purpose': purpose},
        ),
      );

      return Right(User.fromMap(response.data));
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, bool>> setPin(String pin) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          accountEndpoints.pinSetup,
          {'pin': pin},
        ),
      );
      return Right(response.status);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, bool>> forgotPasswordInit(AuthParams params) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          authEndpoints.forgotPasswordInitiated,
          params.toMap(),
        ),
      );
      return Right(response.status);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, bool>> forgotPasswordReset(
    AuthParams params,
  ) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          authEndpoints.forgotPasswordReset,
          params.toMap(),
        ),
      );
      return Right(response.status);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }
}
