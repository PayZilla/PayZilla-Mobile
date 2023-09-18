import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';

// ignore: one_member_abstracts
abstract class IProfileRemoteDataSource {
  Future<bool> uploadImage(String url);
  Future<User> updateProfile(AuthParams params);
}

class ProfileRemoteDataSource implements IProfileRemoteDataSource {
  ProfileRemoteDataSource(this.http);

  final HttpManager http;
  @override
  Future<bool> uploadImage(String url) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          userEndpoints.avatarUpload,
          {'avatar_url': url},
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
  Future<User> updateProfile(AuthParams params) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          userEndpoints.getUser,
          params.toMap(),
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
}
