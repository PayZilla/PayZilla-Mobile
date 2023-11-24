import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/profile/profile.dart';

// ignore: one_member_abstracts
abstract class IProfileRemoteDataSource {
  Future<Either<ApiFailure, bool>> uploadImage(String url);
  Future<Either<ApiFailure, User>> updateProfile(AuthParams params);
  Future<Either<ApiFailure, List<FAQsModel>>> getFAQs();
}

class ProfileRemoteDataSource implements IProfileRemoteDataSource {
  ProfileRemoteDataSource(this.http);

  final HttpManager http;
  @override
  Future<Either<ApiFailure, bool>> uploadImage(String url) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          userEndpoints.avatarUpload,
          {'avatar_url': url},
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
  Future<Either<ApiFailure, User>> updateProfile(AuthParams params) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          userEndpoints.getUser,
          params.toMap(),
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
  Future<Either<ApiFailure, List<FAQsModel>>> getFAQs() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(othersEndpoints.faqs),
      );

      return Right(
        (response.data as List)
            .map((e) => FAQsModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }
}
