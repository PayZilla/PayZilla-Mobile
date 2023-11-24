import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/core/mixins/use_case.dart';
import 'package:pay_zilla/features/auth/auth.dart';

class GetUserUseCase implements UseCase<User, NoParams> {
  GetUserUseCase({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<ApiFailure, User>> call(NoParams params) {
    return authRepository.getUser();
  }
}

// KYC USE CASE

class GetUserKycUseCase implements UseCase<List<dynamic>, NoParams> {
  GetUserKycUseCase({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<ApiFailure, List<dynamic>>> call(NoParams params) {
    return authRepository.getKyc();
  }
}
