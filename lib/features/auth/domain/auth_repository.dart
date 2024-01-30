import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';

// ignore: one_member_abstracts
abstract class AuthRepository {
  Future<Either<ApiFailure, UserAuthModel>> login(AuthParams param);
  Future<Either<Failure, User>> getUser();
  Future<Either<ApiFailure, List>> getKyc();
  Future<Either<ApiFailure, UserAuthModel>> signUp(AuthParams param);
  Future<Either<ApiFailure, List<ReasonsModel>>> fetchReasons();
  Future<Either<ApiFailure, String>> emailVerificationInitiate();
  Future<Either<ApiFailure, String>> tokenVerification(AuthParams params);
  Future<Either<ApiFailure, String>> initializeBvn();
  Future<Either<ApiFailure, bool>> updateBvn(AuthParams params);
  Future<Either<ApiFailure, User>> purpose(List<String> purpose);
  Future<Either<ApiFailure, bool>> forgotPasswordInit(AuthParams params);
  Future<Either<ApiFailure, bool>> forgotPasswordReset(AuthParams params);
  Future<Either<ApiFailure, bool>> pinSetup(String params);
}

class AuthRepositoryImp implements AuthRepository {
  AuthRepositoryImp({
    required this.remoteDataSource,
    required this.localAuthentication,
  });

  final IAuthRemoteDataSource remoteDataSource;
  final LocalAuthentication localAuthentication;

  Future<Either<Failure, Unit>> useLocalAuth() async {
    try {
      final authenticated = await localAuthentication.authenticate(
        localizedReason: 'Authenticate to continue',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (authenticated) return const Right(unit);
      return Left(LocalAuthFailure());
    } catch (_) {
      return Left(LocalAuthFailure());
    }
  }

  @override
  Future<Either<ApiFailure, UserAuthModel>> login(
    AuthParams requestDto,
  ) async {
    return remoteDataSource.login(requestDto);
  }

  @override
  Future<Either<Failure, User>> getUser() {
    // localDataSource.saveAuthUserPref(response);
    return remoteDataSource.getUser();
  }

  @override
  Future<Either<ApiFailure, List>> getKyc() async {
    return remoteDataSource.getKyc();
  }

  @override
  Future<Either<ApiFailure, UserAuthModel>> signUp(
    AuthParams requestDto,
  ) async {
    return remoteDataSource.signUp(requestDto);
  }

  @override
  Future<Either<ApiFailure, List<ReasonsModel>>> fetchReasons() async {
    return remoteDataSource.fetchReasons();
  }

  @override
  Future<Either<ApiFailure, String>> emailVerificationInitiate() async {
    return remoteDataSource.emailVerificationInitiate();
  }

  @override
  Future<Either<ApiFailure, String>> tokenVerification(
    AuthParams params,
  ) async {
    return remoteDataSource.tokenVerification(params);
  }

  @override
  Future<Either<ApiFailure, String>> initializeBvn() async {
    return remoteDataSource.initializeBvn();
  }

  @override
  Future<Either<ApiFailure, bool>> updateBvn(AuthParams params) async {
    return remoteDataSource.updateBvn(params);
  }

  @override
  Future<Either<ApiFailure, User>> purpose(List<String> purpose) async {
    return remoteDataSource.purpose(purpose);
  }

  @override
  Future<Either<ApiFailure, bool>> forgotPasswordInit(AuthParams params) async {
    return remoteDataSource.forgotPasswordInit(params);
  }

  @override
  Future<Either<ApiFailure, bool>> forgotPasswordReset(
    AuthParams params,
  ) async {
    return remoteDataSource.forgotPasswordReset(params);
  }

  @override
  Future<Either<ApiFailure, bool>> pinSetup(String pin) async {
    return remoteDataSource.setPin(pin);
  }
}
