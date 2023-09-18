import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/profile/profile.dart';

class ProfileRepository extends Repository {
  ProfileRepository({
    required this.remoteDataSource,
  });

  final IProfileRemoteDataSource remoteDataSource;

  Future<Either<Failure, bool>> uploadImage(String profileUrl) async {
    return runGuard(() async {
      final response = await remoteDataSource.uploadImage(profileUrl);

      return response;
    });
  }

  Future<Either<Failure, User>> updateProfile(AuthParams params) async {
    return runGuard(() async {
      final response = await remoteDataSource.updateProfile(params);

      return response;
    });
  }
}
