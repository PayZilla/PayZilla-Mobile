import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/profile/profile.dart';

abstract class ProfileRepository {
  Future<Either<ApiFailure, bool>> uploadImage(String profileUrl);
  Future<Either<ApiFailure, User>> updateProfile(AuthParams params);
  Future<Either<ApiFailure, List<FAQsModel>>> getFAQs();
}

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileRepositoryImpl({
    required this.remoteDataSource,
  });

  final IProfileRemoteDataSource remoteDataSource;

  @override
  Future<Either<ApiFailure, bool>> uploadImage(String profileUrl) async {
    return remoteDataSource.uploadImage(profileUrl);
  }

  @override
  Future<Either<ApiFailure, User>> updateProfile(AuthParams params) async {
    return remoteDataSource.updateProfile(params);
  }

  @override
  Future<Either<ApiFailure, List<FAQsModel>>> getFAQs() async {
    return remoteDataSource.getFAQs();
  }
}
