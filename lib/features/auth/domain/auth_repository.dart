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
  final LocalAuthentication localAuthentication;

  set biometricMode(bool value) =>
      localDataSource.saveBiometricMode(value: value);

  Future<bool> isLocalAuthEnabled() async {
    final isEnabled = await localAuthentication.canCheckBiometrics;
    final hasOneOrMoreBiometric =
        (await localAuthentication.getAvailableBiometrics()).isNotEmpty;
    return isEnabled && hasOneOrMoreBiometric;
  }

  Future<bool> canUseBiometric() async {
    final isBiometricsEnabled = await isLocalAuthEnabled();
    final isBiometricsPrefEnabled =
        await localDataSource.getBiometricMode ?? false;
    final email = await localDataSource.getUserEmail();
    final password = await localDataSource.getUserPassword();
    return email.isNotEmpty &&
        password.isNotEmpty &&
        isBiometricsEnabled &&
        isBiometricsPrefEnabled;
  }

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

  Future<Either<Failure, UserAuthModel>> login(
    AuthParams requestDto,
  ) async {
    return runGuard(() async {
      localDataSource.flushLocalStorage();

      final response = await remoteDataSource.login(requestDto);
      localDataSource
        ..saveUserEmail(response.user.email)
        ..saveToken(response.accessToken)
        ..saveUserPassword(requestDto.password);
      await getUser();

      return response;
    });
  }

  Future<Either<Failure, User>> getUser() async {
    return runGuard(() async {
      final response = await remoteDataSource.getUser();
      localDataSource.saveAuthUserPref(response);
      return response;
    });
  }

  Future<Either<Failure, List>> getKyc() async {
    return runGuard(() async {
      final response = await remoteDataSource.getKyc();
      return response;
    });
  }

  Future<Either<Failure, UserAuthModel>> signUp(
    AuthParams requestDto,
  ) async {
    return runGuard(() async {
      localDataSource.flushLocalStorage();
      final response = await remoteDataSource.signUp(requestDto);
      localDataSource
        ..saveUserEmail(response.user.email)
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

  Future<Either<Failure, String>> emailVerificationInitiate() async {
    return runGuard(() async {
      final response = await remoteDataSource.emailVerificationInitiate();
      return response;
    });
  }

  Future<Either<Failure, String>> tokenVerification(
    AuthParams params, {
    required String path,
    String? email,
  }) async {
    return runGuard(() async {
      final response = await remoteDataSource.tokenVerification(
        params,
        path: path,
      );
      return response;
    });
  }

  Future<Either<Failure, bool>> initializeBvn(AuthParams params) async {
    return runGuard(() async {
      final response = await remoteDataSource.initializeBvn(params);
      return response;
    });
  }

  Future<Either<Failure, bool>> updateBvn(AuthParams params) async {
    return runGuard(() async {
      final response = await remoteDataSource.updateBvn(params);
      return response;
    });
  }

  Future<Either<Failure, User>> purpose(List<String> purpose) async {
    return runGuard(() async {
      final response = await remoteDataSource.purpose(purpose);
      return response;
    });
  }

  Future<Either<Failure, bool>> forgotPasswordInit(AuthParams params) async {
    return runGuard(() async {
      final response = await remoteDataSource.forgotPasswordInit(params);
      return response;
    });
  }

  Future<Either<Failure, bool>> forgotPasswordReset(AuthParams params) async {
    return runGuard(() async {
      final response = await remoteDataSource.forgotPasswordReset(params);
      return response;
    });
  }
}
