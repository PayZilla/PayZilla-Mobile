import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/core/mixins/use_case.dart';
import 'package:pay_zilla/features/auth/auth.dart';

class LogInUseCase implements UseCase<UserAuthModel, AuthParams> {
  LogInUseCase({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<ApiFailure, UserAuthModel>> call(AuthParams params) {
    return authRepository.login(params);
  }
}

// sign up use case
class SignUpUseCase implements UseCase<UserAuthModel, AuthParams> {
  SignUpUseCase({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<ApiFailure, UserAuthModel>> call(AuthParams params) {
    return authRepository.signUp(params);
  }
}

// email verification use case
class EmailVerificationUseCase implements UseCase<String, NoParams> {
  EmailVerificationUseCase({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<ApiFailure, String>> call(NoParams params) {
    return authRepository.emailVerificationInitiate();
  }
}

// token verification use case
class TokenVerificationUseCase implements UseCase<String, AuthParams> {
  TokenVerificationUseCase({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<ApiFailure, String>> call(AuthParams params) {
    return authRepository.tokenVerification(params);
  }
}

// pin setup use case
class PinSetupUseCase implements UseCase<bool, String> {
  PinSetupUseCase({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<ApiFailure, bool>> call(String params) {
    return authRepository.pinSetup(params);
  }
}

// fetch reason use case
class FetchReasonsUseCase implements UseCase<List<ReasonsModel>, NoParams> {
  FetchReasonsUseCase({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<ApiFailure, List<ReasonsModel>>> call(NoParams params) {
    return authRepository.fetchReasons();
  }
}

// initialize BVN use case
class InitializeBvnUseCase implements UseCase<String, NoParams> {
  InitializeBvnUseCase({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<ApiFailure, String>> call(NoParams params) {
    return authRepository.initializeBvn();
  }
}

// update BVN use case
class UpdateBvnUseCase implements UseCase<bool, AuthParams> {
  UpdateBvnUseCase({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<ApiFailure, bool>> call(AuthParams params) {
    return authRepository.updateBvn(params);
  }
}

// forgot password use case
class ForgotPasswordUseCase implements UseCase<bool, AuthParams> {
  ForgotPasswordUseCase({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<ApiFailure, bool>> call(AuthParams params) {
    return authRepository.forgotPasswordInit(params);
  }
}

// forgot password reset use case
class ForgotPasswordResetUseCase implements UseCase<bool, AuthParams> {
  ForgotPasswordResetUseCase({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<ApiFailure, bool>> call(AuthParams params) {
    return authRepository.forgotPasswordReset(params);
  }
}

//  purpose use case
class PurposeUseCase implements UseCase<User, List<String>> {
  PurposeUseCase({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<ApiFailure, User>> call(List<String> purpose) {
    return authRepository.purpose(purpose);
  }
}
