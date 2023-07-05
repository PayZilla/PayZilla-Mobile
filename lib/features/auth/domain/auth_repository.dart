import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';

class AuthRepository extends Repository {
  AuthRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.localAuthentication,
  });

  final IAuthRemoteDataSource remoteDataSource;
  final IAuthLocalDataSource localDataSource;
  final LocalAuthentication
      localAuthentication; // TODO(Dev): Use this to handle the biometrics sign in .

  set biometricMode(bool value) =>
      localDataSource.saveBiometricMode(value: value);

  Future<Either<Failure, AuthResponseData>> login(
    AuthParams requestDto,
  ) async {
    return runGuard(() async {
      localDataSource.flushLocalStorage();

      final response = await remoteDataSource.login(requestDto);
      localDataSource
        ..saveUserEmail(response.email)
        ..saveToken(response.accessToken)
        ..saveUserPassword(requestDto.password);
      await getUser();

      return response;
    });
  }

  Future<Either<Failure, dynamic>> getUser() async {
    return runGuard(() async {
      final response = await remoteDataSource.getUser();
      localDataSource.saveAuthUserPref(response);
      return response;
    });
  }

  Future<Either<Failure, AuthResponseData>> signUp(
    AuthParams requestDto,
  ) async {
    return runGuard(() async {
      localDataSource.flushLocalStorage();
      final response = await remoteDataSource.signUp(requestDto);
      localDataSource
        ..saveUserEmail(response.email)
        ..saveToken(response.accessToken);
      await getUser();

      return response;
    });
  }

  Future<Either<Failure, List<ReasonsModel>>> fetchReasons() async {
    return runGuard(() async {
      final response = await remoteDataSource.fetchReasons();
      return response;
    });
  }
}
