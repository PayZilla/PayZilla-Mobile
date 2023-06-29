import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';

abstract class IAuthRemoteDataSource {
  Future<dynamic> login(AuthParams params);
  Future<dynamic> getUser();
  Future<dynamic> signUp(AuthParams params);
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  AuthRemoteDataSource(this.http);
  final HttpManager http;

  @override
  Future<dynamic> login(AuthParams params) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          authEndpoints.login,
          params.toMap(),
        ),
      );
      if (response.isResultOk) {
        return AuthResponseData.fromJson(response.data);
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getUser() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(userEndpoints.getUser),
      );
      if (response.isResultOk) {
        return response.data;
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<dynamic> signUp(AuthParams params) async {
    try {
      final response = ResponseDto.fromMap(
        await http.patch(
          authEndpoints.signUp,
          params.toMap(),
        ),
      );
      if (response.isResultOk) {
        return AuthResponseData.fromJson(response.toJson());
      }

      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }
}
