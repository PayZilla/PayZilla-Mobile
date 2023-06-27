import 'package:dio/dio.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';

class AuthAndRefreshTokenInterceptor extends Interceptor {
  AuthAndRefreshTokenInterceptor({
    required this.cache,
    required this.baseUrl,
  });
  final ILocalCache cache;
  final String baseUrl;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await cache.get<String>(CacheKeys.token);
    var isExpired = false;
    if (token != null) {
      isExpired = Jwt.isExpired(token);

      if (isExpired) {
        handler.reject(
          DioError(
            requestOptions: options,
            error: SessionExpiredServerException(),
          ),
        );
      } else {
        /// token is valid continue with request
        handler.next(
          options.copyWith(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ),
        );
      }
    } else {
      /// token is not available continue with request
      handler.next(
        options.copyWith(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
    }
  }
}
